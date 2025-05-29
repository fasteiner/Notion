# Detect OS and set the destination path
if ($IsWindows) {
    $codeFolder = "Code"
    $destPath = Join-Path -Path $env:APPDATA -ChildPath "$codeFolder\User\vsicons-custom-icons"
}
elseif ($IsMacOS) {
    $codeFolder = "Code"
    $destPath = "$HOME/Library/Application Support/$codeFolder/User/vsicons-custom-icons"
}
elseif ($IsLinux) {
    $codeFolder = "Code"
    $destPath = "$HOME/.config/$codeFolder/User/vsicons-custom-icons"
}
else {
    Write-Error "Unsupported operating system."
    exit 1
}

# Ensure the destination directory exists
if (-not (Test-Path -Path $destPath)) {
    New-Item -ItemType Directory -Path $destPath -Force | Out-Null
}

# Copy the icon from the script's directory
$sourceIcon = Join-Path -Path $PSScriptRoot -ChildPath "file_type_pester.svg"
Copy-Item -Path $sourceIcon -Destination $destPath -Force

Write-Host "✅ Icon copied to: $destPath"
