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
