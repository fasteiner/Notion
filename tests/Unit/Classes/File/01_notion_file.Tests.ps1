# Import the module containing the notion_file class
# Import the module containing the Get-NotionUser function
Import-Module Pester

BeforeDiscovery {
    $projectPath = "$($PSScriptRoot)/../../../.." | Convert-Path

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

    $mut = Import-Module -Name "$projectPath/output/module/$ProjectName" -Force -ErrorAction Stop -PassThru

}

Describe "notion_file Class Tests" {
    Context "Constructor Tests" {
        It "should create a notion_file object with type" -TestCases @(
            @{type = "file"}
            @{type = "external"}
        ){
            param ($type)
            $file = [notion_file]::new($type)
            $file.type | Should -Be $type
        }

        It "should create a notion_file object with type and name" -TestCases @(
            @{type = "file"}
            @{type = "external"}
        ){
            $name = "Test File"
            $file = [notion_file]::new($type, $name)
            $file.type | Should -Be $type
            $file.name | Should -Be $name
        }

        It "should create a notion_file object with type, name, and caption" -TestCases @(
            @{type = "file"}
            @{type = "external"}
        ) {
            $name = "Test File"
            $caption = "Test Caption"
            $file = [notion_file]::new($type, $name, $caption)
            $file.type | Should -Be $type
            $file.name | Should -Be $name
            $file.caption[0].plain_text | Should -Be $caption
        }

        It "should create a notion_file object with type, name, and rich_text[] caption"-TestCases @(
            @{type = "file"}
            @{type = "external"}
        ) {
            $name = "Test File"
            $caption = @([rich_text_text]::new("Test Caption"))
            $file = [notion_file]::new($type, $name, $caption)
            $file.type | Should -Be $type
            $file.name | Should -Be $name
            $file.caption[0].plain_text | Should -Be $caption.plain_text
        }
    }

    Context "Static Method Tests" {

        It "should convert from object to notion_file" {
            $type = "file"
            $name = "Test File"
            $caption = @(@{
                type = "text"
                text = @{
                    content = "Test Caption"
                    link = $null
                }
                plain_text = "Test Caption"
            }
            $file = @{
                url = "https://example.com/file"
                expiry_time = ([datetime]::UtcNow).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ss.fffZ")
            }
            )
            $value = @{
                type = $type
                name = $name
                caption = $caption
                file = $file
            }
            $file = [notion_file]::ConvertFromObject($value)
            $file.type | Should -Be $type
            $file.name | Should -Be $name
            $file.caption[0].plain_text | Should -Be $caption[0].plain_text
        }
        It "should convert from object to notion_external_file" {
            $type = "external"
            $name = "Test File"
            $caption = @(@{
                type = "text"
                text = @{
                    content = "Test Caption"
                    link = $null
                }
                plain_text = "Test Caption"
            }
            $file = @{
                url = "https://example.com/file"
            }
            )
            $value = @{
                type = $type
                name = $name
                caption = $caption
                external = $file
            }
            $file = [notion_file]::ConvertFromObject($value)
            $file.type | Should -Be $type
            $file.name | Should -Be $name
            $file.caption[0].plain_text | Should -Be $caption[0].plain_text
        }
    }
}
