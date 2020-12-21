### ----------------------------------------------------------- ###
### Set Execution Policy to allow for Powershell scripts to run ###
### ----------------------------------------------------------- ###

$OriginalExecutionPolicy = Get-ExecutionPolicy -Scope CurrentUser              # Save original execution policy to reset to later
if($OriginalExecutionPolicy -match "Undefined") {                              # Check to ensure execution policy actually needs to be changed
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser       # Set the execution policy for the current user to Remote Signed
}
