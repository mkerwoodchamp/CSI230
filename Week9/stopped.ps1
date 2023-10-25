Get-Service | where { $_.Status -eq "Stopped" } | Sort-Object | `
Export-Csv -Path "C:\Users\champuser\CSI230\Week9\stoppedProcesses.csv" -NoTypeInformation 