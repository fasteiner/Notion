# Step 1: Define variables
$ModulePath = "./output/module/Notion"  # Path to the built module
$ApiKey = $env:PSGalleryApiKey    # PowerShell Gallery API Key from an environment variable
$projectPath = "$($PSScriptRoot)" | Convert-Path

if (-not $ProjectName)
{
    # Assuming project folder name is project name.
    $ProjectName = Get-SamplerProjectName -BuildRoot $projectPath
}
Write-Debug "ProjectName: $ProjectName"
$moduleName = $ProjectName

$ModulePath = "./output/module/$moduleName"

# Step 2: Validate the module path
if (-Not (Test-Path -Path $ModulePath)) {
    Write-Error "Module path '$ModulePath' does not exist. Ensure the module is built correctly."
    exit 1
}
# find the module version
$folders = Get-ChildItem -Path $ModulePath -Directory
$version = $folders | Sort-Object -Property Name -Descending | Select-Object -First 1 -ExpandProperty Name


# Step 3: Publish the module
try {
    Publish-Module -Path $ModulePath/$version -Repository PSGallery -NuGetApiKey $ApiKey -Force -ErrorAction Stop
    Write-Host "Module published successfully to the PowerShell Gallery." -ForegroundColor Green
} catch {
    Write-Error "Failed to publish module: $_"
    exit 1
}
