# Network Scanner with Hostnames + Logging (Fast)
param(
    [string]$Base = "192.168.1.",
    [int]$Start = 1,
    [int]$End = 50,
    [string]$LogFile = "NetworkScan_Log.txt"
)

# Timestamp header
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
Add-Content $LogFile "==============================="
Add-Content $LogFile "Scan started: $timestamp"
Add-Content $LogFile "Range: $Base$Start to $Base$End"
Add-Content $LogFile "==============================="

Write-Host "Scanning $Base$Start to $Base$End ..." -ForegroundColor Cyan

# Parallel scan
$jobs = @()
for ($i=$Start; $i -le $End; $i++) {
    $ip = "$Base$i"
    $jobs += Start-Job -ScriptBlock {
        param($ip,$LogFile)
        $result = Test-Connection -ComputerName $ip -Count 1 -Quiet -ErrorAction SilentlyContinue
        if ($result) {
            try {
                $hostname = ([System.Net.Dns]::GetHostEntry($ip)).HostName
            } catch {
                $hostname = "Unknown"
            }
            Write-Output "$ip is ONLINE - Hostname: $hostname"
            Add-Content $LogFile "$ip is ONLINE - Hostname: $hostname"
        } else {
            Write-Output "$ip is offline"
            Add-Content $LogFile "$ip is offline"
        }
    } -ArgumentList $ip,$LogFile
}

# Wait for jobs to finish and display results
$jobs | ForEach-Object { Receive-Job $_ -Wait; Remove-Job $_ }

Write-Host "Scan complete. Results saved to $LogFile" -ForegroundColor Green