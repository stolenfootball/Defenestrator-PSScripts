###----------------------------------### 
### Remove unnecessary Appx Packages ###
###----------------------------------###

$User = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name       # Get the username of the current user
$Packages = Get-AppxPackage -User "$User" | Select Name                      # Get a list of all Appx packages that are installed for the current user

$ToRemove = "Microsoft.ZuneMusic",                                           # List of Appx packages to remove
"Microsoft.XboxIdentityProvider",                               
"Microsoft.BingTravel",
"Microsoft.BingHealthAndFitness",
"Microsoft.BingFoodAndDrink",
"Microsoft.BingFinance",
"Microsoft.3DBuilder",
"Microsoft.BingNews",
"Microsoft.XboxApp",
"Microsoft.BingSports",
"Microsoft.WindowsMaps",
"Microsoft.MicrosoftSolitaireCollection",
"Microsoft.BingWeather",
"Microsoft.Office.OneNote",
"Microsoft.SkypeApp",
"Microsoft.XboxSpeechToTextOverlay",
"Microsoft.MSPaint",
"Microsoft.OneConnect",
"Microsoft.MicrosoftOfficeHub",
"Microsoft.NetworkSpeedTest",
"Microsoft.Office.Sway",
"Microsoft.OfficeLens",
"Microsoft.Whiteboard",
"Microsoft.Xbox.TCUI",
"Microsoft.XboxGameOverlay",
"Microsoft.MixedReality.Portal",
"Microsoft.Todos",
"Microsoft.XboxGamingOverlay",
"Microsoft.Microsoft3DViewer",
"Microsoft.Messaging",
"Microsoft.Print3D",
"Microsoft.ScreenSketch",
"Microsoft.RemoteDesktop",
"57540AMZNMobileLLC.AmazonAlexa",
"SpotifyAB.SpotifyMusic"

foreach($Package in $Packages) {                                             # Cycle thrrough all Appx packages installed for the user
    foreach($Remove in $ToRemove) {                                          # Cycle through all Appx packages to be removed
        if($Package.Name -match $Remove) {                                   # Attempt to match each installed package to a removal entry
            Get-AppxPackage $Package | Remove-AppxPackage                    # Remove the installed package if it finds a match
        }
    }

}