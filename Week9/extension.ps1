cd "C:\Users\champuser\CSI230\Week9"
$files= Get-ChildItem 
$files | Where-Object { $_.Extension -like ".ps1" } | sort CreationDate
