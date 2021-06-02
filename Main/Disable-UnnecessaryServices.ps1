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


### ------------------------------------------------- ###
### Disable various tracking and advertising services ###
### ------------------------------------------------- ###

# Disable Telemetry and Data Collection
Reg Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /T REG_DWORD /V "AllowTelemetry" /D 0 /F

# Disable targeted advertising 
Reg Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /T REG_DWORD /V "DisabledByGroupPolicy" /D 1 /F

# Turn off Website Access of Language List
Reg Add "HKEY_CURRENT_USER\Control Panel\International\User Profile" /T REG_DWORD /V "HttpAcceptLanguageOptOut" /D 1 /F

# Turn of Windows Track app launches
Reg Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /T REG_DWORD /V "Start_TrackProgs" /D 0 /F

# Turn off Suggested content in the settings app
Reg Add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /T REG_DWORD /V "SubscribedContent-338393Enabled" /D 0 /F
Reg Add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /T REG_DWORD /V "SubscribedContent-353694Enabled" /D 0 /F
Reg Add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /T REG_DWORD /V "SubscribedContent-353696Enabled" /D 0 /F

# Turn off Activity History
Reg Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /T REG_DWORD /V "PublishUserActivities" /D 0 /F

# Turn off Tailored Experience based off diagnostic data
Reg Add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Privacy" /T REG_DWORD /V "TailoredExperiencesWithDiagnosticDataEnabled" /D 0 /F


### --------------------------------- ###
### Disable unwanted rarely used apps ###
### --------------------------------- ###

# Disable Cortana
Reg Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /T REG_DWORD /V "Allow Cortana" /D 1 /F

# Turn off Meet Now
Reg Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /T REG_DWORD /V "HideSCAMeetNow" /D 1 /F


### ----------------------- ###
### Disable Gaming Services ###
### ----------------------- ###

#Disable Game Monitoring Service
Reg Add "HKLM\SYSTEM\CurrentControlSet\Services\xbgm" /T REG_DWORD /V "Start" /D 4 /F

#GameDVR local GP - Computer Config\Admin Templates\Windows Components\Windows Game Recording and Broadcasting
Reg Add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /T REG_DWORD /V "AllowGameDVR" /D 0 /F

# Game Bar
Reg Add "HKEY_CURRENT_USER\Software\Microsoft\GameBar" /T REG_DWORD /V "UseNexusForGameBarEnabled" /D 0 /F
Reg Add "HKEY_CURRENT_USER\Software\Microsoft\GameBar" /T REG_DWORD /V "AutoGameModeEnabled" /D 0 /F

# Game Config Store
Reg Add "HKEY_CURRENT_USER\System\GameConfigStore" /T REG_DWORD /V "GameDVR_Enabled" /D 0 /F
Reg Add "HKEY_CURRENT_USER\System\GameConfigStore" /T REG_DWORD /V "GameDVR_FSEBehavior" /D 2 /F
Reg Add "HKEY_CURRENT_USER\System\GameConfigStore" /T REG_DWORD /V "GameDVR_FSEBehaviorMode" /D 2 /F
Reg Add "HKEY_CURRENT_USER\System\GameConfigStore" /T REG_DWORD /V "GameDVR_HonorUserFSEBehaviorMode" /D 0 /F
Reg Add "HKEY_CURRENT_USER\System\GameConfigStore" /T REG_DWORD /V "GameDVR_DXGIHonorFSEWindowsCompatible" /D 0 /F
Reg Add "HKEY_CURRENT_USER\System\GameConfigStore" /T REG_DWORD /V "GameDVR_EFSEFeatureFlags" /D 0 /F


### ----------------------------------- ###
### Wait for keypress to dismiss window ###
### ----------------------------------- ###

$Waiter = Read-Host -Prompt 'Press any key to continue...'