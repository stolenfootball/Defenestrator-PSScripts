###-----------------------------------------------------------------------------------###
### Check to see if the console is already an administrator, and elevate if it is not ###
###-----------------------------------------------------------------------------------###

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

