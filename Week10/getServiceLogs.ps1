$values = @('all', 'Stopped', 'Running')

choose

function choose() {
$values[0..2]

$viewService = Read-Host -Prompt `
"Please enter a type from the list above or 'q' to quit the program"

if ($viewService -match "^[qQ]$"){
    break
}

serviceView -serviceType $viewService
}

function serviceView(){
Param([string]$serviceType)

if($serviceType -eq $values[0]) {
Get-Service
}
elseif($serviceType -eq $values[1]) {
Get-Service | Where-Object { $_.Status -eq $values[1] }
}
elseif($serviceType -eq $values[2]) {
Get-Service | Where-Object { $_.Status -eq $values[2] }
}
else {
Write-Host "Please enter a valid type"
}

choose
}