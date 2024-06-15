# Parameters
$sourceDrive = "C:"
$blockSize = 4MB
$ncatUrl = "https://github.com/cyberisltd/NcatPortable/raw/master/ncat.exe"  # URL to download ncat
$ncatPath = "$env:TEMP\ncat.exe"  # Path to save downloaded ncat
$targetIP = "127.0.0.1"  # Update this to the receiver's IP address
$targetPort = 12345

# Download ncat
Invoke-WebRequest -Uri $ncatUrl -OutFile $ncatPath

# Open a file stream for reading the source drive
$driveStream = [System.IO.File]::OpenRead("\\.\$sourceDrive`:")

# Create a buffer
$buffer = New-Object byte[] $blockSize

# Create the Netcat process
$ncProcess = Start-Process -FilePath $ncPath -ArgumentList "$targetIP $targetPort" -NoNewWindow -RedirectStandardInput -PassThru

# Write the drive data to the Netcat process
try {
    while ($bytesRead = $driveStream.Read($buffer, 0, $buffer.Length)) {
        $ncProcess.StandardInput.BaseStream.Write($buffer, 0, $bytesRead)
        $ncProcess.StandardInput.BaseStream.Flush()
    }
} finally {
    $driveStream.Close()
    $ncProcess.StandardInput.Close()
    $ncProcess.WaitForExit()
}

Write-Output "Cloning and transfer completed successfully."
