cd "C:\Users\champuser\CSI230"

$FilesToLookAt = Get-ChildItem -Recurse -Filter "*.bash"

for ($i=0; $i -lt $FilesToLookAt.Count; $i++){
Get-Content $FilesToLookAt[$i].FullName | Measure-Object -Line -Word
}