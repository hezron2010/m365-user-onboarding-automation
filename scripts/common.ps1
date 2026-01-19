# common.ps1

$LogFile = "../logs/onboarding.log"
$DryRun  = $true   # Set to $false to execute actions

function Write-Log {
    param ([string]$Message, [string]$Level = "INFO")
    $Time = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$Time [$Level] $Message" | Tee-Object -FilePath $LogFile -Append
}

function Execute-Action {
    param ([scriptblock]$Action, [string]$Description)

    if ($DryRun) {
        Write-Log "DRY-RUN: $Description"
    } else {
        try {
            & $Action
            Write-Log "$Description - SUCCESS"
        } catch {
            Write-Log "$Description - FAILED: $_" "ERROR"
        }
    }
}
