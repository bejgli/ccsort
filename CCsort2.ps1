if (!($args.Count -EQ 1)) {Write-Output "Give exactly one file-name to look for. Exiting."; Exit 1}

$Name = $args[0]
$Files = @(Get-ChildItem -Path "./" -File | Where-Object {$_.Name -Match "$Name"})
$Count = $Files.Count
$NewCount = 0
$DuplicateCount = 0

if ($Count -EQ 0) {"No file(s) with name $Name found. Exiting."; Exit 0}

if (!(Test-Path -Path $Name -PathType "Container")) {
    New-Item -Path "./" -Name "$Name" -ItemType "Directory"
}

foreach ($File in $Files) {
    Move-Item -Path "$File" -Destination "./$Name/" 2> $null
    if ($?){$NewCount++;Write-Output "Moving $File.."}
    else {Write-Output "Couldn't move $File. Probably a duplicate.";$DuplicateCount++;Continue}
}

Write-Output "Done. $NewCount file(s) moved. $DuplicateCount duplicate(s) found."
Exit 0
