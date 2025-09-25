Import-Module Pester -DisableNameChecking

BeforeDiscovery {
    $projectPath = "$($PSScriptRoot)/../../../.." | Convert-Path

    if (-not $ProjectName)
    {
        $ProjectName = Get-SamplerProjectName -BuildRoot $projectPath
    }
    Write-Debug "ProjectName: $ProjectName"
    $global:moduleName = $ProjectName

    Remove-Module -Name $global:moduleName -Force -ErrorAction SilentlyContinue
    $mut = Import-Module -Name "$projectPath/output/module/$ProjectName" -Force -ErrorAction Stop -PassThru
}

Describe "notion_code_block Tests" {
    Context "Constructor Tests" {
        It "Should create an empty notion_code_block" {
            $block = [notion_code_block]::new()
            $block | Should -BeOfType "notion_code_block"
            $block.type | Should -Be "code"
            ($block.code.GetType().Name) | Should -Be "code_structure"
            $block.code.rich_text | Should -BeNullOrEmpty
            $block.code.getLanguage() | Should -BeNullOrEmpty
        }

        It "Should create a notion_code_block with text and language" {
            $block = [notion_code_block]::new("Write-Host 'Hello'", "powershell")
            $block.code.rich_text[0].plain_text | Should -Be "Write-Host 'Hello'"
            $block.code.getLanguage() | Should -Be "powershell"
        }

        It "Should create a notion_code_block with text, caption and language" {
            $block = [notion_code_block]::new("Write-Host 'Hi'", "This is a caption", "powershell")
            $block.code.rich_text[0].plain_text | Should -Be "Write-Host 'Hi'"
            $block.code.caption[0].plain_text | Should -Be "This is a caption"
            $block.code.getLanguage() | Should -Be "powershell"
        }

        It "Should throw on invalid language" {
            { [notion_code_block]::new("code", "invalidLang") } | Should -Throw
        }
    }

    Context "ConvertFromObject Tests" {
        It "Should convert from object correctly" {
            $mock = [PSCustomObject]@{
                code = [PSCustomObject]@{
                    caption   = @([PSCustomObject]@{
                            type       = "text"
                            text       = @{ content = "Caption" }
                            plain_text = "Caption"
                        })
                    rich_text = @([PSCustomObject]@{
                            type       = "text"
                            text       = @{ content = "Code content" }
                            plain_text = "Code content"
                        })
                    language  = "python"
                }
            }
            $block = [notion_code_block]::ConvertFromObject($mock)
            $block | Should -BeOfType "notion_code_block"
            ($block.code.GetType().Name) | Should -Be "code_structure"
            $block.code.rich_text[0].plain_text | Should -Be "Code content"
            $block.code.caption[0].plain_text | Should -Be "Caption"
            $block.code.getLanguage() | Should -Be "python"
        }

        It "Should throw on invalid language in ConvertFromObject" {
            $mock = [PSCustomObject]@{
                code = [PSCustomObject]@{
                    caption   = @()
                    rich_text = @()
                    language  = "invalidLang"
                }
            }
            { [notion_code_block]::ConvertFromObject($mock) } | Should -Throw
        }
    }
}
