#######################################################################################
#####                                                                             #####
#####   Script to remove various Windows 10 bloatware that comes auto installed   #####
#####                                                                             #####
#######################################################################################



### --------------------------------------------------------------------------------- ###
### Check to see if the console is already an administrator, and elevate if it is not ###
### --------------------------------------------------------------------------------- ###

$myWindowsID=[System.Security.Principal.WindowsIdentity]::GetCurrent()                         # Get the ID and security principal of the current user account
$myWindowsPrincipal=new-object System.Security.Principal.WindowsPrincipal($myWindowsID)

$adminRole=[System.Security.Principal.WindowsBuiltInRole]::Administrator                       # Get the security principal for the Administrator role

if ($myWindowsPrincipal.IsInRole($adminRole)) {                                                # Check to see if we are currently running "as Administrator"
   $Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + "(Elevated)"              # We are running "as Administrator" - so change the title and background color to indicate this
   $Host.UI.RawUI.BackgroundColor = "DarkBlue"
   clear-host
}
else {                                                                                         # We are not running "as Administrator" - so relaunch as administrator  
   $newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";                  # Create a new process object that starts PowerShell
   $newProcess.Arguments = $myInvocation.MyCommand.Definition;                                 # Specify the current script path and name as a parameter
   $newProcess.Verb = "runas";                                                                 # Indicate that the process should be elevated
                                                                  
   [System.Diagnostics.Process]::Start($newProcess);                                           # Start the new process
   exit                                                                                        # Exit from the current, unelevated, process
}


### ---------------------------------------------- ###
### Remove Unnecessary Online Provisioned Packages ###
### ---------------------------------------------- ###

$ProvisionedPackages = Get-ProvisionedAppxPackage -Online | Select DisplayName, PackageName                        # Get a list of all Provisioned Appx packages by Display Name and Full Package Name

$ProvisionedToRemove = "Microsoft.BingWeather",                                                                    # List of provisioned packages to remove by Display Name
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
"Microsoft.ZuneVideo",
"microsoft.windowscommunicationsapps"

foreach($ProvisionedPackage in $ProvisionedPackages) {                                                              # Cycle thrrough all Provisioned Appx packages installed for the user
    foreach($ProvisionedRemove in $ProvisionedToRemove) {                                                           # Cycle through all Provisioned Appx packages to be removed
        if($ProvisionedPackage.DisplayName -match $ProvisionedRemove) {                                             # Attempt to match each installed provisioned package Display Name to a removal entry
            Write-Output "Removing " $ProvisionedPackage.DisplayName                                                # Display the package being removed
            Remove-ProvisionedAppxPackage -Online -AllUsers -PackageName $ProvisionedPackage.PackageName            # Remove the installed package if it finds a match using the Package Name associated with the Display Name
        }
    }

}

 
### -------------------------------- ### 
### Remove unnecessary Appx Packages ###
### -------------------------------- ###

$Packages = Get-AppxPackage -AllUsers | Select Name                             # Get a list of all Appx packages that are installed for the current user

$ToRemove = "Microsoft.ZuneMusic",                                              # List of Appx packages to remove
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

foreach($Package in $Packages) {                                               # Cycle thrrough all Appx packages installed for the user
    foreach($Remove in $ToRemove) {                                            # Cycle through all Appx packages to be removed
        if($Package.Name -match $Remove) {                                     # Attempt to match each installed package to a removal entry
            Write-Output "Removing " $Package.Name                       
            Get-AppxPackage -AllUsers $Package.Name | Remove-AppxPackage       # Remove the installed package if it finds a match
        }
    }

}


### ----------------------------------- ###
### Wait for keypress to dismiss window ###
### ----------------------------------- ###

$Waiter = Read-Host -Prompt 'Press any key to continue...'