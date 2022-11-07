# ****************************************************************************************************************************
#
# Purpose: This Script was to written detect the existence of Specific WUfB Registry Keys
# written to the local registry either from GPO or other 3rd Party Tool, to the
# HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate and \AU registry hive
#   https://learn.microsoft.com/en-us/windows/deployment/update/wufb-wsus  
#   **Excluding policies pushed via MDM such as Intune** 
#
# ------------- DISCLAIMER -------------------------------------------------------------------------------------------------------
# This script code is provided as is with no guarantee or warranty concerning
# the usability or impact on systems and may be used, distributed, and
# modified in any way provided the parties agree and acknowledge the 
# Microsoft or Microsoft Partners have neither accountability or 
# responsibility for results produced by use of this script.
#
# Microsoft will not provide any support through any means.
# ------------- DISCLAIMER ---------------------------------------------------------------------------------------------------------
#
# **********************************************************************************************************************************

Write-Host "Checking for elevated permissions..."
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
[Security.Principal.WindowsBuiltInRole] "Administrator")) {
Write-Warning "Insufficient permissions to run this script. Open the PowerShell console as an administrator and run this script again."
Break
}
else {
Write-Host "Code is running as administrator — go on executing the script..." -ForegroundColor Yellow
}

Clear-Host
write-host `n
write-host "         Specify source service for specific classes of Windows Updates           "`n -ForegroundColor White 
write-host "                       And other WUfB Policy Checks...                            "`n -ForegroundColor White 
write-host ""
write-host "   This Script was written to detect the existence of Specific WUfB Registry Keys " -ForegroundColor Cyan
write-host "   written to the local registry either from GPO or other 3rd Party Tool, to the  " -ForegroundColor Cyan
write-host "   HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate and \AU registry hive  " -ForegroundColor White
write-host "       https://learn.microsoft.com/en-us/windows/deployment/update/wufb-wsus      " -ForegroundColor White
write-host "               **Excluding policies pushed via MDM such as Intune**               "`n -ForegroundColor Cyan
write-host "                **This Script is Provided AS IS with no support**                 "`n -ForegroundColor Red

$hive =  "HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate", "HKLM:\Software\Policies\Microsoft\Windows"
foreach ($keyhive in $hive) {
    if (Test-Path $keyhive) {
        $Keys = "DeferFeatureUpdates", "DeferFeatureUpdatesPeriodInDays", "PauseFeatureUpdatesStartTime", "DeferQualityUpdates", "DeferQualityUpdatesPeriodInDays", "PauseQualityUpdatesStartTime", "ScheduleInstallDay",
        "ScheduleInstallTime", "ExcludeWUDriversInQualityUpdate", "BranchReadinessLevel", "DoNotConnectToWindowsUpdateInternetLocations", "DisableWindowsUpdateAccess", "UseWUServer", "WUServer", "UseUpdateClassPolicySource", 
        "SetPolicyDrivenUpdateSourceForOtherUpdates", "SetPolicyDrivenUpdateSourceForDriverUpdates", "SetPolicyDrivenUpdateSourceForQualityUpdates", "SetPolicyDrivenUpdateSourceForFeatureUpdates", "AUOptions", "AllowAutoUpdate"
        foreach ($key in $Keys) {
            $data = @(get-childitem "$keyhive" -Recurse | Get-ItemProperty -Name WindowsUpdate, $key -ErrorAction Ignore) 
            foreach ($value in $data) {
                if ($key -eq "DeferFeatureUpdates") {
                    if ($data.$key -eq 1) {
                        Write-Host
                        Write-Host -ForegroundColor Cyan `t$key
                        Write-Host -ForegroundColor Red `tThe $key Key is Enabled with Value $data.$key
                        Write-Host -ForegroundColor Red `tWindows Autopatch does not support the use of this key.
                    }
                    else {
                        Write-Host
                        Write-Host -ForegroundColor Cyan `t$key
                        Write-Host -ForegroundColor Yellow `tThe $key Key is not configured nor has any value.
                    }
                }
                elseif ($key -eq "DeferFeatureUpdatesPeriodInDays") {
                    if ($null -ne $data.$key) {
                        Write-Host
                        Write-Host -ForegroundColor Cyan `t$key
                        Write-Host -ForegroundColor Red `tThe $key Key is Configured with Value $data.$key Days
                        Write-Host -ForegroundColor Red `tWindows Autopatch does not support the use of this key.
                    }
                    else {
                        Write-Host
                        Write-Host -ForegroundColor Cyan `t$key
                        Write-Host -ForegroundColor Yellow `tThe $key Key is not configured nor has any value.
                    }
                }
                elseif ($key -eq "PauseFeatureUpdatesStartTime") {
                    if ($null -ne $data.$key) {
                        Write-Host
                        Write-Host -ForegroundColor Cyan `t$key
                        Write-Host -ForegroundColor Yellow `tThe $key Key is not configured nor has any value.
                    }
                    else {
                                                Write-Host
                        Write-Host -ForegroundColor Cyan `t$key
                        Write-Host -ForegroundColor Red `tThe $key Key is Configured with Value $data.$key Days
                        Write-Host -ForegroundColor Red `tWindows Autopatch does not support the use of this key.
                    }
                }
                elseif ($key -eq "DeferQualityUpdates") {
                    if ($data.$key -eq 1) {
                        Write-Host
                        Write-Host -ForegroundColor Cyan `t$key
                        Write-Host -ForegroundColor Red `tThe $key Key is Configured with Value $data.$key Days
                        Write-Host -ForegroundColor Red `tWindows Autopatch does not support the use of this key.
                    }
                    else {
                        Write-Host
                        Write-Host -ForegroundColor Cyan `t$key
                        Write-Host -ForegroundColor Yellow `tThe $key Key is not configured nor has any value.
                    }
                }
                elseif ($key -eq "DeferQualityUpdatesPeriodInDays") {
                    if ($null -ne $data.$key) {
                        Write-Host
                        Write-Host -ForegroundColor Cyan `t$key
                        Write-Host -ForegroundColor Red `tThe $key Key is Configured with Value $data.$key Days
                        Write-Host -ForegroundColor Red `tWindows Autopatch does not support the use of this key.
                    }
                    else {
                        Write-Host
                        Write-Host -ForegroundColor Cyan `t$key
                        Write-Host -ForegroundColor Yellow `tThe $key Key is not configured nor has any value.
                    }
                }
                elseif ($key -eq "PauseQualityUpdatesStartTime") {
                    if ($null -ne $data.$key) {
                        Write-Host
                        Write-Host -ForegroundColor Cyan `t$key
                        Write-Host -ForegroundColor Yellow `tThe $key Key is not configured nor has any value.
                    }
                    else {
                        Write-Host
                        Write-Host -ForegroundColor Cyan `t$key
                        Write-Host -ForegroundColor Red `tThe $key Key is Configured with Value $data.$key Days
                        Write-Host -ForegroundColor Red `tWindows Autopatch does not support the use of this key.
                    }
                }
                elseif ($key -eq "ScheduleInstallDay") {
                    if ($null -ne $data.$key) {
                        Write-Host
                        Write-Host -ForegroundColor Cyan `t$key
                        Write-Host -ForegroundColor Yellow `tThe $key Key is not configured nor has any value.
                    }
                    else {
                        Write-Host
                        Write-Host -ForegroundColor Cyan `t$key
                        Write-Host -ForegroundColor Red `tThe $key Key is Configured with Value $data.$key Days
                        Write-Host -ForegroundColor Red `tWindows Autopatch does not support the use of this key.
                    }
                }
                elseif ($key -eq "ScheduleInstallTime") {
                    if ($null -ne $data.$key) {
                        Write-Host
                        Write-Host -ForegroundColor Cyan `t$key
                        Write-Host -ForegroundColor Yellow `tThe $key Key is not configured nor has any value.
                    }
                    else {
                        Write-Host
                        Write-Host -ForegroundColor Cyan `t$key
                        Write-Host -ForegroundColor Red `tThe $key Key is Configured with Value $data.$key Days
                        Write-Host -ForegroundColor Red `tWindows Autopatch does not support the use of this key.
                    }
                }
                elseif ($key -eq "ExcludeWUDriversInQualityUpdate") {
                    if ($data.$key -eq 1) {
                        Write-Host
                        Write-Host -ForegroundColor Cyan `t$key
                        Write-Host -ForegroundColor Red `tThe $key Key is Configured with Value $data.$key Days
                        Write-Host -ForegroundColor Red `tWindows Autopatch does not support the use of this key.
                    }
                    else {
                        Write-Host
                        Write-Host -ForegroundColor Cyan `t$key
                        Write-Host -ForegroundColor Yellow `tThe $key Key is not configured nor has any value.
                    }
                }
                elseif ($key -eq "BranchReadinessLevel") {
                    if ($null -ne $data.$key) {
                        Write-Host
                        Write-Host -ForegroundColor Cyan `t$key
                        Write-Host -ForegroundColor Yellow `tThe $key Key is not configured nor has any value.
                    }
                    else {
                        Write-Host    
                        Write-Host -ForegroundColor Cyan `t$key
                        Write-Host -ForegroundColor Red `tThe $key Key is Configured with Value $data.$key
                        Write-Host -ForegroundColor Red `tWindows Autopatch does not support the use of this key.
                    }
                }
                elseif ($key -eq "DoNotConnectToWindowsUpdateInternetLocations") {
                    if ($data.$key -eq 1) {
                        Write-Host
                        Write-Host -ForegroundColor Cyan `t$key
                        Write-Host -ForegroundColor Red `tThe $key Key is Configured with Value $data.$key Days
                        Write-Host -ForegroundColor Red `tWindows Autopatch does not support the use of this key.
                    }
                    else {
                        Write-Host
                        Write-Host -ForegroundColor Cyan `t$key
                        Write-Host -ForegroundColor Yellow `tThe $key Key is not configured nor has any value.
                    }
                }
                elseif ($key -eq "DisableWindowsUpdateAccess") {
                    if ($data.$key -eq 1) {
                        Write-Host
                        Write-Host -ForegroundColor Cyan `t$key
                        Write-Host -ForegroundColor Red `tThe $key Key is Configured with Value $data.$key Days
                        Write-Host -ForegroundColor Red `tWindows Autopatch does not support the use of this key.
                    }
                    else {
                        Write-Host
                        Write-Host -ForegroundColor Cyan `t$key
                        Write-Host -ForegroundColor Yellow `tThe $key Key is not configured nor has any value.
                    }
                }
                elseif ($key -eq "UseWUServer") {
                    if ($data.$key -eq 1) {
                        Write-Host
                        Write-Host -ForegroundColor Cyan `t$key
                        Write-Host -ForegroundColor Yellow `tThe $key Key is Enabled with Value $data.$key
                        Write-Host -ForegroundColor Yellow "`tWindows Autopatch only supports WSUS for 3rd Party Software"
                        Write-Host -ForegroundColor Yellow "`tThe Quality, Features, and Drivers below should be set to WU"
                        $UseWUServer = "true"
                    }
                    else {
                        Write-Host
                        Write-Host -ForegroundColor Cyan `t$key
                        Write-Host -ForegroundColor Yellow `tThe $key Key is Disabled with Value $data.$key
                    }
                }
                elseif ($key -eq "WUServer") {
                    if ($null -ne $data.$key) {
                        Write-Host
                        Write-Host -ForegroundColor Cyan `t$key
                        Write-Host -ForegroundColor Yellow `tThe $key String is Populated with Value $data.$key
                        Write-Host -ForegroundColor Yellow "`tWindows Autopatch only supports WSUS for 3rd Party Software"
                        Write-Host -ForegroundColor Yellow "`tThe Quality, Features, and Drivers below should be set to WU"
                    }
                    else {
                        Write-Host
                        Write-Host -ForegroundColor Cyan `t$key
                        Write-Host -ForegroundColor Yellow `tThe $key String is null and has no value
                    }
                }
                elseif ($key -eq "UseUpdateClassPolicySource") {
                    if (($data.$key -eq 1) -and ($UseWUServer -eq "true")) {
                        Write-Host
                        Write-Host -ForegroundColor Cyan `t$key
                        Write-Host -ForegroundColor Yellow "`tThe $key Key is Enabled with WSUS server string"
                        Write-Host -ForegroundColor Yellow "`tWindows Autopatch only supports WSUS for 3rd Party Software"
                        Write-Host -ForegroundColor Yellow "`tThe Quality, Features, and Drivers below should be set to WU"
                        $UseUpdateClassPolicySource = "true"
                    }
                    elseif ($data.$key -eq 1) {
                        Write-Host
                        Write-Host -ForegroundColor Cyan `t$key
                        Write-Host -ForegroundColor Yellow "`tThe $key Key is Enabled without a WSUS server string"
                        Write-Host -ForegroundColor Red "`t**This is unexpected please validate your configurations**"
                    }
                    else {
                        Write-Host
                        Write-Host -ForegroundColor Cyan `t$key
                        Write-Host -ForegroundColor Yellow `tThe $key Key is Not Configured nor has any value
                    }
                }
                elseif ($key -eq "SetPolicyDrivenUpdateSourceForOtherUpdates") {
                    if (($data.$key -eq 1) -and ($UseWUServer -eq "true") -and ($UseUpdateClassPolicySource -eq "true")) {
                        Write-Host
                        Write-Host -ForegroundColor Cyan `t$key
                        Write-Host -ForegroundColor Yellow "`tThe $key Key is Enabled with WSUS server string"
                        Write-Host -ForegroundColor Yellow "`tWindows Update other Updates are configured for WSUS"
                    }
                    elseif ($data.$key -eq 1 -and ($UseUpdateClassPolicySource -eq "true")) {
                        Write-Host
                        Write-Host -ForegroundColor Cyan `t$key
                        Write-Host -ForegroundColor Yellow "`tThe $key Key is Enabled without a WSUS server string"
                        Write-Host -ForegroundColor Red "`t**This is unexpected please validate your configurations**"
                    }
                    elseif ($data.$key -eq 0 -and ($UseUpdateClassPolicySource -eq "true")) {
                        Write-Host
                        Write-Host -ForegroundColor Cyan `t$key
                        Write-Host -ForegroundColor Yellow "`tThe $key Key is Enabled and configured for Windows Update"
                    }
                    else {
                        Write-Host
                        Write-Host -ForegroundColor Cyan `t$key
                        Write-Host -ForegroundColor Yellow `tThe $key Key is Not Configured with Value $data.$key
                    }
                }
                elseif ($key -eq "SetPolicyDrivenUpdateSourceForDriverUpdates") {
                    if (($data.$key -eq 1) -and ($UseWUServer -eq "true") -and ($UseUpdateClassPolicySource -eq "true")) {
                        Write-Host
                        Write-Host -ForegroundColor Cyan `t$key
                        Write-Host -ForegroundColor Red "`tThe $key Key is Enabled with WSUS server string"
                        Write-Host -ForegroundColor Red "`tWindows Autopatch does not support the use of this key."
                    }
                    elseif ($data.$key -eq 1 -and ($UseUpdateClassPolicySource -eq "true")) {
                        Write-Host
                        Write-Host -ForegroundColor Cyan `t$key
                        Write-Host -ForegroundColor Yellow "`tThe $key Key is Enabled without a WSUS server string"
                        Write-Host -ForegroundColor Red "`t**This is unexpected please validate your configurations**"
                    }
                    elseif ($data.$key -eq 0 -and ($UseUpdateClassPolicySource -eq "true")) {
                        Write-Host
                        Write-Host -ForegroundColor Cyan `t$key
                        Write-Host -ForegroundColor Yellow "`tThe $key Key is Enabled and configured for Windows Update"
                    }
                    else {
                        Write-Host
                        Write-Host -ForegroundColor Cyan `t$key
                        Write-Host -ForegroundColor Yellow `tThe $key Key is Not Configured with Value $data.$key
                    }
                }
                elseif ($key -eq "SetPolicyDrivenUpdateSourceForQualityUpdates") {
                    if (($data.$key -eq 1) -and ($UseWUServer -eq "true") -and ($UseUpdateClassPolicySource -eq "true")) {
                        Write-Host
                        Write-Host -ForegroundColor Cyan `t$key
                        Write-Host -ForegroundColor Red "`tThe $key Key is Enabled with WSUS server string"
                        Write-Host -ForegroundColor Red "`tWindows Autopatch does not support the use of this key."
                    }
                    elseif ($data.$key -eq 1 -and ($UseUpdateClassPolicySource -eq "true")) {
                        Write-Host
                        Write-Host -ForegroundColor Cyan `t$key
                        Write-Host -ForegroundColor Yellow "`tThe $key Key is Enabled without a WSUS server string"
                        Write-Host -ForegroundColor Red "`t**This is unexpected please validate your configurations**"
                    }
                    elseif ($data.$key -eq 0 -and ($UseUpdateClassPolicySource -eq "true")) {
                        Write-Host
                        Write-Host -ForegroundColor Cyan `t$key
                        Write-Host -ForegroundColor Yellow "`tThe $key Key is Enabled and configured for Windows Update"
                    }
                    else {
                        Write-Host
                        Write-Host -ForegroundColor Cyan `t$key
                        Write-Host -ForegroundColor Yellow `tThe $key Key is Not Configured with Value $data.$key
                    }
                }
                elseif ($key -eq "SetPolicyDrivenUpdateSourceForFeatureUpdates") {
                    if (($data.$key -eq 1) -and ($UseWUServer -eq "true") -and ($UseUpdateClassPolicySource -eq "true")) {
                        Write-Host
                        Write-Host -ForegroundColor Cyan `t$key
                        Write-Host -ForegroundColor Red "`tThe $key Key is Enabled with WSUS server string"
                        Write-Host -ForegroundColor Red "`tWindows Autopatch does not support the use of this key."
                    }
                    elseif ($data.$key -eq 1 -and ($UseUpdateClassPolicySource -eq "true")) {
                        Write-Host
                        Write-Host -ForegroundColor Cyan `t$key
                        Write-Host -ForegroundColor Yellow "`tThe $key Key is Enabled without a WSUS server string"
                        Write-Host -ForegroundColor Red "`t**This is unexpected please validate your configurations**"
                    }
                    elseif ($data.$key -eq 0 -and ($UseUpdateClassPolicySource -eq "true")) {
                        Write-Host
                        Write-Host -ForegroundColor Cyan `t$key
                        Write-Host -ForegroundColor Yellow "`tThe $key Key is Enabled and configured for Windows Update"
                    }
                    else {
                        Write-Host
                        Write-Host -ForegroundColor Cyan `t$key
                        Write-Host -ForegroundColor Yellow `tThe $key Key is Not Configured with Value $data.$key
                    }
                }
                else {
                    Write-Host
                    Write-Host -ForegroundColor Yellow `tThe $key Key was not Found!! 
                }
            }
        }
    }
    else {
        Write-Host -ForegroundColor Yellow "`tNon of the monitored Keys were found"  
        Write-Host -ForegroundColor Yellow "`tThis script only check non MDM keys!!"  
        Write-Host -ForegroundColor Yellow `t$keyhive  
    }
}

