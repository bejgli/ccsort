$Name = $args[0]

if (!( Test-Path -Path "$Name")){New-Item -Path "./" -Name "$Name" -ItemType "directory"}
Get-ChildItem -Path "./" -File | Where-Object {$_.Name -Match "$Name"} | Move-Item -Destination "./$Name/" #-Force
Write-Output "Done. $Count"

