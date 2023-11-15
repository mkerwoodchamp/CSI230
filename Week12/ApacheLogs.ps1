clear

# Get-Content C:\xampp\apache\logs\access.log

#Get-Content C:\xampp\apache\logs\access.log -TotalCount 5

#Get-Content C:\xampp\apache\logs\access.log | Select-String ' 404 ',' 400 '

$B = Get-Content C:\xampp\apache\logs\access.log | Select-String ' 200 ' -NotMatch
#$B

#$A = Get-ChildItem C:\xampp\apache\logs\*.log | Select-String 'error' 
#$A[-5..-1]

$regex = [regex] "((?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?\.){3}(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)))"
$ips = $regex.matches($B) | select @{Name="IP"; Expression={ $_.value }}

$counts = $ips | Group-Object IP -NoElement

$countsDetailed = $counts | select Count, Name, `
@{Name="Decision"; Expression={ if( $_.Count -gt 3 ) {"Abnormal"} `
                                else {"Normal"}
                                }}

foreach($ip in $countsDetailed){

    if([string]$ip.Decision -like "Abnormal") {
    Write-Host "Blocking $ip.Name"
    New-NetFirewallRule -DisplayName "Bad IPs $ip.Name" `
    -Direction Inbound -Action Block -RemoteAddress $ip.Name
    }
}

Remove-NetFirewallRule -DisplayName "Bad IPs*"