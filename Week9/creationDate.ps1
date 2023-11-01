$files = Get-ChildItem | Where-Object {$_.CreationTime -ge "10/24/2023"} | Select Name, CreationTime
$files | Export-Csv -Path "C:\Users\champuser\CSI230\creationDate.csv" -NoTypeInformation