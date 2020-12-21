### --------------------------------------------- ###
### Remove Windows 10 Online Provisioned Packages ###
### --------------------------------------------- ###

$ProvisionedPackages = Get-ProvisionedAppxPackage -Online | Select DisplayName, PackageName                           # Get a list of all Provisioned Appx packages by Display Name and Full Package Name

$ProvisionedToRemove = "Microsoft.BingWeather",                                                                       # List of provisioned packages to remove by Display Name
"Microsoft.GetHelp",
"Microsoft.Getstarted",
"Microsoft.Messaging",
"Microsoft.Microsoft3DViewer",
"Microsoft.MicrosoftOfficeHub",
"Microsoft.MicrosoftSolitaireCollection",
"Microsoft.MicrosoftStickyNotes",
"Microsoft.MixedReality.Portal",
"Microsoft.MSPaint",
"Microsoft.Office.OneNote",
"Microsoft.OneConnect",
"Microsoft.People",
"Microsoft.Print3D",
"Microsoft.ScreenSketch",
"Microsoft.SkypeApp",
"Microsoft.StorePurchaseApp",
"Microsoft.Wallet",
"Microsoft.WindowsCamera",
"Microsoft.WindowsFeedbackHub",
"Microsoft.WindowsMaps",
"Microsoft.WindowsSoundRecorder",
"Microsoft.Xbox.TCUI",
"Microsoft.XboxApp",
"Microsoft.XboxGameOverlay",
"Microsoft.XboxGamingOverlay",
"Microsoft.XboxIdentityProvider",
"Microsoft.XboxSpeechToTextOverlay",
"Microsoft.YourPhone",
"Microsoft.ZuneMusic",
"Microsoft.ZuneVideo"

$i = 0
foreach($ProvisionedPackage in $ProvisionedPackages) {                                                                 # Cycle thrrough all Provisioned Appx packages installed for the user
    foreach($ProvisionedRemove in $ProvisionedToRemove) {                                                              # Cycle through all Provisioned Appx packages to be removed
        if($ProvisionedPackage.DisplayName -match $ProvisionedRemove) {                                                # Attempt to match each installed provisioned package Display Name to a removal entry
            $i += 1
            Write-Output $i
            Remove-ProvisionedAppxPackage -Online -AllUsers -PackageName $ProvisionedPackage.PackageName               # Remove the installed package if it finds a match using the Package Name associated with the Display Name
        }
    }

}