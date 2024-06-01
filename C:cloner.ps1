# Parameters
$sourceDrive = "C:"
$blockSize = 4MB
$ncPath = "C:\path\to\nc.exe"  # Update this path to where your nc.exe is located
$targetIP = "192.168.43.101"  # Update this to the receiver's IP address
$targetPort = 12345

# Open a file stream for reading the source drive
$driveStream = [System.IO.File]::OpenRead("\\.\$sourceDrive`:")

# Create a buffer
$buffer = New-Object byte[] $blockSize

# Create the Netcat process
$ncProcess = Start-Process -FilePath $ncPath -ArgumentList "$targetIP $targetPort" -NoNewWindow -RedirectStandardInput "C:\path\to\temp\input.bin" -PassThru

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
