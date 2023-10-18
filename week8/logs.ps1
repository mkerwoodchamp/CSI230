
Get-Eventlog -list

$readLog = Read-host -Prompt "Please choose a log to export to a csv file: "

Get-EventLog -LogName $readLog -Newest 3 | export-csv -NoTypeInformation -Path "C:\Users\champuser\Desktop\rep.csv"
