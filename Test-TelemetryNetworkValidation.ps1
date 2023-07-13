# ***************************************************************************
#
# Purpose: Script to Validate Telemetry endpoint avaliblilty for Autopatch. 
#
# ------------- DISCLAIMER -------------------------------------------------
# This script code is provided as is with no guarantee or waranty concerning
# the usability or impact on systems and may be used, distributed, and
# modified in any way provided the parties agree and acknowledge the 
# Microsoft or Microsoft Partners have neither accountabilty or 
# responsibility for results produced by use of this script.
#
# Microsoft will not provide any support through any means.
# ------------- DISCLAIMER -------------------------------------------------
#
# ***************************************************************************

$hash = @{
    'v10.events.data.microsoft.com' = '443'
    'v10c.events.data.microsoft.com' = '443'
    'v10.vortex-win.data.microsoft.com' = '443'
    'watson.telemetry.microsoft.com' = '443'
    'umwatsonc.events.data.microsoft.com' = '443'
    'ceuswatcab01.blob.core.windows.net' = '443'
    'ceuswatcab02.blob.core.windows.net' = '443'
    'eaus2watcab01.blob.core.windows.net' = '443'
    'eaus2watcab02.blob.core.windows.net' = '443'
    'weus2watcab01.blob.core.windows.net' = '443'
    'weus2watcab02.blob.core.windows.net' = '443'
    'login.live.com' = '443'
    'oca.telemetry.microsoft.com' = '443'
    'oca.microsoft.com' = '443'
    'kmwatsonc.events.data.microsoft.com' = '443'
    'settings-win.data.microsoft.com' = '443'
    }

    ForEach ($h in $hash.GetEnumerator() ){

    try{
        
        if (Test-NetConnection -ComputerName $($h.Name) -Port $($h.Value) -InformationLevel Quiet -ErrorAction Stop){
            
            Write-Host "$($h.Name) = PASS" -ForegroundColor Green

        }else{
            
            Write-Host "$($h.Name) = FAILED" -ForegroundColor Red
        
        }
    
    }catch{

    }
    }

    pause
