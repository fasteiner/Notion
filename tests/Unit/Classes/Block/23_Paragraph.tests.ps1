Import-Module Pester

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

Describe "notion_paragraph_block Tests" {
    Context "Constructor Tests" {
        It "Should create an empty notion_paragraph_block" {
            $block = [notion_paragraph_block]::new()
            $block | Should -BeOfType "notion_paragraph_block"
            $block.type | Should -Be "paragraph"
            ($block.paragraph.GetType().Name) | Should -Be "paragraph_structure"
            $block.paragraph.rich_text | Should -BeNullOrEmpty
            "$($block.paragraph.color)" | Should -Be "default"
            $block.paragraph.children | Should -BeNullOrEmpty
        }

        It "Should create a notion_paragraph_block with rich_text" {
            $rt = [rich_text_text]::new("Hello world")
            $block = [notion_paragraph_block]::new(@($rt))
            $block.paragraph.rich_text.Count | Should -Be 1
            $block.paragraph.rich_text[0].plain_text | Should -Be "Hello world"
            $block.paragraph.color.ToString() | Should -Be "default"
        }
    }

    Context "ConvertFromObject Tests" {
        It "Should convert from object correctly" {
            $mock = [PSCustomObject]@{
                paragraph = [PSCustomObject]@{
                    rich_text = @([PSCustomObject]@{
                            type       = "text"
                            text       = @{ content = "Converted text" }
                            plain_text = "Converted text"
                        })
                    color     = "blue"
                }
            }
            $block = [notion_paragraph_block]::ConvertFromObject($mock)
            $block | Should -BeOfType "notion_paragraph_block"
            ($block.paragraph.GetType().Name) | Should -Be "paragraph_structure"
            $block.paragraph.rich_text[0].plain_text | Should -Be "Converted text"
            $block.paragraph.color.ToString() | Should -Be "blue"
        }

        It "Should default to 'default' color if none provided" {
            $mock = [PSCustomObject]@{
                paragraph = [PSCustomObject]@{
                    rich_text = @([PSCustomObject]@{
                            type       = "text"
                            text       = @{ content = "No color" }
                            plain_text = "No color"
                        })
                }
            }
            $block = [notion_paragraph_block]::ConvertFromObject($mock)
            $block.paragraph.color.ToString() | Should -Be "default"
        }
    }
}
