# Import the module containing the notion_file class
# Import the module containing the Get-TSNotionUser function
Import-Module Pester

BeforeDiscovery {
    $projectPath = "$($PSScriptRoot)\..\..\..\.." | Convert-Path

    <#
        If the QA tests are run outside of the build script (e.g with Invoke-Pester)
        the parent scope has not set the variable $ProjectName.
    #>
    if (-not $ProjectName)
    {
        # Assuming project folder name is project name.
        $ProjectName = Get-SamplerProjectName -BuildRoot $projectPath
    }
    Write-Debug "ProjectName: $ProjectName"
    $global:moduleName = $ProjectName

    Remove-Module -Name $global:moduleName -Force -ErrorAction SilentlyContinue

    $mut = Get-Module -Name $global:moduleName -ListAvailable |
        Select-Object -First 1 |
            Import-Module -Force -ErrorAction Stop -PassThru
    Write-Debug "Imported module $($mut.Name)"
}


Describe "external_file" {
    It "should create an instance with the correct properties" {
        $name = "Test File"
        $caption = "Test Caption"
        $url = "http://example.com"
        $externalFile = [notion_external_file]::new($name, $caption, $url)
        $externalFile.name | Should -Be $name
        $externalFile.caption[0].plain_text | Should -Be $caption
        $externalFile.external.url | Should -Be $url
    }

    It "should convert from object correctly" {
        $name = "Test File"
        $caption = @(
            @{
                type = "text"
                text = @{
                    content = "Test Caption"
                    link = $null
                }
                plain_text = "Test Caption"
            }
        )
        $url = "http://example.com"
        $object = [pscustomobject]@{
            type = "external"
            name = $name
            caption = $caption
            external = [pscustomobject]@{ url = $url }
        }
        $externalFile = [notion_external_file]::ConvertFromObject($object)
        $externalFile.name | Should -Be $name
        $externalFile.caption[0].plain_text | Should -Be "Test Caption"
        $externalFile.external.url | Should -Be $url
    }
}
