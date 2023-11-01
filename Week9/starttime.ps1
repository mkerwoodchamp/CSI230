$currentTime= Get-Date
$oneHourPrior= $currentTime.AddHours(-1)

$recentProcesses = Get-Process | Where-Object { $_.StartTime -ge $oneHourPrior }
$filteredProcesses = $recentProcesses | Where-Object { $_.ProcessName -like 'C*' }

$filteredProcesses