# Get the directory of the current PowerShell script
$scriptDir = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition

# Define the output file path within an "Outputs" folder relative to the script directory
$outputFilePath = Join-Path -Path $scriptDir -ChildPath "Outputs\performance_log.csv"

# Ensure the Outputs directory exists; create it if it doesn't
$outputDir = Split-Path -Path $outputFilePath
if (-not (Test-Path -Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir | Out-Null
}

# Define the performance counters to monitor
$performanceCounters = @(
    "\Processor(_Total)\% Processor Time",
    "\Memory\Available MBytes",
    "\PhysicalDisk(_Total)\Disk Read Bytes/sec",
    "\PhysicalDisk(_Total)\Disk Write Bytes/sec",
    "\Network Interface(*)\Bytes Received/sec",
    "\Network Interface(*)\Bytes Sent/sec"
)

# Create an object for exporting to CSV
$results = @()

# Define the duration and interval for monitoring (in seconds)
$duration = 3600  # 1 hour
$interval = 5     # 5 seconds

# Calculate the end time
$endTime = (Get-Date).AddSeconds($duration)

# Start the monitoring loop
while ((Get-Date) -lt $endTime) {
    # Get the current timestamp
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

    # Create a custom object to hold the performance data
    $result = New-Object PSObject -Property @{
        Timestamp = $timestamp
    }

    # Iterate through the performance counters and collect the data
    foreach ($counter in $performanceCounters) {
        $value = (Get-Counter -Counter $counter).CounterSamples.CookedValue | Measure-Object -Average | Select-Object -ExpandProperty Average
        $result | Add-Member -MemberType NoteProperty -Name $counter -Value $value
    }

    # Add the result to the results array
    $results += $result

    # Wait for the specified interval before collecting the next set of data
    Start-Sleep -Seconds $interval
}

# Export the results to a CSV file
$results | Export-Csv -Path $outputFilePath -NoTypeInformation

Write-Host "Performance data collected and saved to $outputFilePath"
