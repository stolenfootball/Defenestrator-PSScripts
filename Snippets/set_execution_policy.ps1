### ----------------------------------------------------------- ###
### Set Execution Policy to allow for Powershell scripts to run ###
### ----------------------------------------------------------- ###

$OriginalExecutionPolicy = Get-ExecutionPolicy -Scope CurrentUser              # Save original execution policy to reset to later
if($OriginalExecutionPolicy -match "Undefined") {                              # Check to ensure execution policy actually needs to be changed
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser       # Set the execution policy for the current user to Remote Signed
}




### --------------------------------------- ###
### Reset Execution Policy back to Unsigned ###
### --------------------------------------- ###

Set-ExecutionPolicy -ExecutionPolicy Undefined -Scope CurrentUser      # Reset Execution policy to a value that does not allow scripts to run for security