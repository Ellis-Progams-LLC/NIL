# Starship Launcher - PowerShell Edition
$logfile = "logs\mission.log"
if (-not (Test-Path "logs")) { New-Item -ItemType Directory -Path "logs" | Out-Null }
Add-Content $logfile "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') Launcher initialized."

function Write-Log($message) {
    Add-Content $logfile "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') $message"
}

function Delay-Random($min, $max) {
    Start-Sleep -Seconds (Get-Random -Minimum $min -Maximum $max)
}

function Boot-Subsystem($name, $failChance, $failMessage, $retryMessage, $successMessage, $colorFail, $colorRetry, $colorSuccess) {
    $fail = (Get-Random -Minimum 0 -Maximum $failChance) -eq 0
    if ($fail) {
        Write-Host $failMessage -ForegroundColor $colorFail
        Write-Log "Boot: $name failed."
        Start-Sleep -Seconds 2
        Write-Host $retryMessage -ForegroundColor $colorRetry
        Start-Sleep -Seconds 2
        Write-Host $successMessage -ForegroundColor $colorSuccess
        Write-Log "Boot: $name restored after retry."
        return $true
    } else {
        Write-Host $successMessage -ForegroundColor $colorSuccess
        Write-Log "Boot: $name complete."
        return $false
    }
}

Clear-Host
$fail_total = 0

Write-Host "?? Initializing Starship Systems..." -ForegroundColor Yellow
Delay-Random 1 3
Write-Log "Boot: Initializing systems."

if (Boot-Subsystem "Diagnostics" 5 "? Diagnostics failed: Core integrity compromised." "?? Retrying diagnostics..." "? Diagnostics restored." "Red" "Cyan" "Green") { $fail_total++ }
Delay-Random 1 3

if ((Get-Random -Minimum 0 -Maximum 6) -eq 0) {
    Write-Host "?? Protocol sync warning: Temporal drift detected." -ForegroundColor DarkYellow
    Write-Log "Boot: Protocol sync warning. Temporal drift detected."
    $fail_total++
} else {
    Write-Host "?? Syncing core protocols..." -ForegroundColor Magenta
    Write-Log "Boot: Core protocols synced."
}
Delay-Random 1 3

if (Boot-Subsystem "Uplink" 4 "? Uplink failed: No signal from command relay." "?? Retrying uplink..." "? Uplink restored." "Red" "Blue" "Green") { $fail_total++ }
Delay-Random 1 3

Write-Host "? System Ready." -ForegroundColor Green
Write-Log "Boot: System ready."
Write-Log "Boot sequence completed."