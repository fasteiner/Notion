Write-Host "Installing PowerShell tooling (Preview versions)..."

# Trust PSGallery
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted

# Install preview modules
Install-Module Pester -Force -AllowPrerelease
Install-Module Microsoft.PowerShell.PlatyPS -Force
Install-Module Sampler -Force -AllowPrerelease

# Add NuGet source if not already added
dotnet nuget add source https://api.nuget.org/v3/index.json -n nuget.org

# Install GitVersion as global tool
dotnet tool install --global GitVersion.Tool --version 5.12.0

# Manuell Pfad zu globalen .NET-Tools ergänzen
$dotnetToolsPath = "$HOME/.dotnet/tools"
if (-not ($env:PATH -like "*$dotnetToolsPath*")) {
    Write-Host "Adding $dotnetToolsPath to PATH..."
    $env:PATH = "$dotnetToolsPath`:$env:PATH"
}

# Optional: Test ob GitVersion jetzt verfügbar ist
dotnet-gitversion /showvariable SemVer || Write-Warning "GitVersion not found in PATH."


# Run a full build of the Notion module
./build.ps1 -tasks build -ResolveDependency -UseModuleFast
