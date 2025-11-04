<#
.SYNOPSIS
    Displays comprehensive system information.

.DESCRIPTION
    Collects and displays detailed information about the system including:
    - Operating System details
    - Hardware specifications (CPU, Memory, Disk)
    - Network configuration
    - Installed software versions

.PARAMETER ExportToFile
    Export results to a file instead of displaying in console.

.PARAMETER Format
    Output format when exporting (JSON, CSV, or Text). Default is JSON.

.PARAMETER OutputPath
    Path where the file should be saved. Default is current directory.

.EXAMPLE
    .\get-system-info.ps1
    Displays system information in the console.

.EXAMPLE
    .\get-system-info.ps1 -ExportToFile -Format JSON
    Exports system information to a JSON file.

.EXAMPLE
    .\get-system-info.ps1 -ExportToFile -Format CSV -OutputPath "C:\Reports\"
    Exports system information to a CSV file in the specified directory.

.NOTES
    Author: ShruggieTech
    Version: 1.0
    Requires: PowerShell 5.1 or later
#>

[CmdletBinding()]
param(
    [Parameter()]
    [switch]$ExportToFile,

    [Parameter()]
    [ValidateSet('JSON', 'CSV', 'Text')]
    [string]$Format = 'JSON',

    [Parameter()]
    [string]$OutputPath = (Get-Location).Path
)

# Collect OS Information
function Get-OSInformation {
    $os = Get-CimInstance Win32_OperatingSystem
    return [PSCustomObject]@{
        Name = $os.Caption
        Version = $os.Version
        Build = $os.BuildNumber
        Architecture = $os.OSArchitecture
        InstallDate = $os.InstallDate
        LastBootTime = $os.LastBootUpTime
    }
}

# Collect CPU Information
function Get-CPUInformation {
    $cpu = Get-CimInstance Win32_Processor
    return [PSCustomObject]@{
        Name = $cpu.Name
        Cores = $cpu.NumberOfCores
        LogicalProcessors = $cpu.NumberOfLogicalProcessors
        MaxClockSpeed = "$($cpu.MaxClockSpeed) MHz"
    }
}

# Collect Memory Information
function Get-MemoryInformation {
    $os = Get-CimInstance Win32_OperatingSystem
    $totalMemoryGB = [math]::Round($os.TotalVisibleMemorySize / 1MB, 2)
    $freeMemoryGB = [math]::Round($os.FreePhysicalMemory / 1MB, 2)
    $usedMemoryGB = $totalMemoryGB - $freeMemoryGB

    return [PSCustomObject]@{
        TotalGB = $totalMemoryGB
        UsedGB = $usedMemoryGB
        FreeGB = $freeMemoryGB
        PercentUsed = [math]::Round(($usedMemoryGB / $totalMemoryGB) * 100, 2)
    }
}

# Collect Disk Information
function Get-DiskInformation {
    $disks = Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3" | ForEach-Object {
        [PSCustomObject]@{
            Drive = $_.DeviceID
            TotalGB = [math]::Round($_.Size / 1GB, 2)
            FreeGB = [math]::Round($_.FreeSpace / 1GB, 2)
            UsedGB = [math]::Round(($_.Size - $_.FreeSpace) / 1GB, 2)
            PercentFree = [math]::Round(($_.FreeSpace / $_.Size) * 100, 2)
        }
    }
    return $disks
}

# Collect Network Information
function Get-NetworkInformation {
    $adapters = Get-NetAdapter | Where-Object { $_.Status -eq 'Up' } | ForEach-Object {
        $ipConfig = Get-NetIPAddress -InterfaceIndex $_.ifIndex -AddressFamily IPv4 -ErrorAction SilentlyContinue
        [PSCustomObject]@{
            Name = $_.Name
            Status = $_.Status
            MACAddress = $_.MacAddress
            IPv4Address = $ipConfig.IPAddress
            LinkSpeed = $_.LinkSpeed
        }
    }
    return $adapters
}

# Main execution
try {
    Write-Host "Collecting system information..." -ForegroundColor Cyan

    $systemInfo = [PSCustomObject]@{
        Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        ComputerName = $env:COMPUTERNAME
        OperatingSystem = Get-OSInformation
        Processor = Get-CPUInformation
        Memory = Get-MemoryInformation
        Disks = @(Get-DiskInformation)
        Network = @(Get-NetworkInformation)
    }

    if ($ExportToFile) {
        $fileName = "SystemInfo_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
        
        switch ($Format) {
            'JSON' {
                $filePath = Join-Path $OutputPath "$fileName.json"
                $systemInfo | ConvertTo-Json -Depth 10 | Out-File $filePath
            }
            'CSV' {
                $filePath = Join-Path $OutputPath "$fileName.csv"
                $systemInfo | Export-Csv $filePath -NoTypeInformation
            }
            'Text' {
                $filePath = Join-Path $OutputPath "$fileName.txt"
                $systemInfo | Out-File $filePath
            }
        }
        
        Write-Host "System information exported to: $filePath" -ForegroundColor Green
    } else {
        # Display in console
        Write-Host "`n=== SYSTEM INFORMATION ===" -ForegroundColor Yellow
        Write-Host "Computer Name: $($systemInfo.ComputerName)" -ForegroundColor White
        Write-Host "Timestamp: $($systemInfo.Timestamp)" -ForegroundColor White
        
        Write-Host "`n--- Operating System ---" -ForegroundColor Cyan
        $systemInfo.OperatingSystem | Format-List
        
        Write-Host "--- Processor ---" -ForegroundColor Cyan
        $systemInfo.Processor | Format-List
        
        Write-Host "--- Memory ---" -ForegroundColor Cyan
        $systemInfo.Memory | Format-List
        
        Write-Host "--- Disks ---" -ForegroundColor Cyan
        $systemInfo.Disks | Format-Table -AutoSize
        
        Write-Host "--- Network Adapters ---" -ForegroundColor Cyan
        $systemInfo.Network | Format-Table -AutoSize
    }

} catch {
    Write-Error "An error occurred while collecting system information: $_"
    exit 1
}
