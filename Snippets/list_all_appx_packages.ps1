$User = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
$Packages = Get-AppxPackage -User "$User" | Select Name

foreach($Element in $Packages) {
$MidElement = $Element.Name -Replace 'Microsoft.', ''
$CleanElement = $MidElement -Replace 'Windows.', ''
    Write-Output $CleanElement
}