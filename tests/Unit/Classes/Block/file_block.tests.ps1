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
}

Describe "notion_file_block Tests" {
    Context "Constructor Tests" {
        It "Should create a notion_file_block with notion_hosted_file" {
            $name = "Test File"
            $caption = "Test Caption"
            $url = "http://example.com/file"
            $expiry_time = "15.11.2023 12:00:00"
            $block = [notion_file_block]::new($name, $caption, $url, $expiry_time)
            
            $block.file | Should -BeOfType "notion_hosted_file"
            $block.file.name | Should -Be $name
            $block.file.caption[0].plain_text | Should -Be $caption
            $block.file.caption[0].type | Should -Be "text"
            $block.file.file.url | Should -Be $url
            $block.file.file.expiry_time | Should -Be (get-date $expiry_time).ToString("yyyy-MM-ddTHH:mm:ss.fffZ")
        }

        It "Should create a notion_file_block with notion_external_file" {
            $name = "Test File"
            $caption = "Test Caption"
            $url = "http://example.com/file"
            $block = [notion_file_block]::new($name, $caption, $url)
            
            $block.file | Should -BeOfType "notion_external_file"
            $block.file.name | Should -Be $name
            $block.file.caption[0].plain_text | Should -Be $caption
            $block.file.external.url | Should -Be $url
        }

        It "Should create a notion_file_block with a notion_file object" {
            $file = [notion_hosted_file]::new()
            $block = [notion_file_block]::new($file)
            
            $block.file | Should -Be $file
        }
    }

    Context "Method Tests" {
        It "Should convert from object correctly" {
            $object = @{
                type = "file"
                object = "block"
                file = @{
                    type = "external"
                    external = @{
                        url = "http://example.com/file"
                    }
                    name = "Test File"
                }
                created_time = "2021-08-17T07:00:00.000Z"
            }
            $convertedBlock = [block]::ConvertFromObject($object)
            
            $convertedBlock.getType().Name | Should -Be "notion_file_block"
            $convertedBlock.file.getType().Name  | Should -Be "external_file"
            $convertedBlock.file.external.url | Should -Be "http://example.com/file"
            $convertedBlock.file.name | Should -Be "Test File"
        }
    }
}
