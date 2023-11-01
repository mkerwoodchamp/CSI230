$chrome = Get-Process | where { $_.ProcessName -eq "chrome" } | `
select Id, ProcessName

if($chrome -eq $null){
Start-Process 'C:\Program Files\Google\Chrome\Application\chrome.exe' -ArgumentList '"https://www.champlain.edu/"'
}
else{
Stop-Process -Name "chrome"
}