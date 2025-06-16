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

Describe "notion_quote_block Tests" {
    Context "Constructor Tests" {
        It "Should create an empty notion_quote_block" {
            $block = [notion_quote_block]::new()
            $block | Should -BeOfType "notion_quote_block"
            $block.type | Should -Be "quote"
            $block.quote | Should -BeNullOrEmpty
        }

        It "Should create a notion_quote_block with rich_text and color" {
            $rt = [rich_text_text]::new("Quote this")
            $block = [notion_quote_block]::new(@($rt), "green")
            $block.quote | Should -Not -BeNullOrEmpty
            ($block.quote.GetType().Name) | Should -Be "Quote_structure"
            $block.quote.rich_text[0].plain_text | Should -Be "Quote this"
            $block.quote.color.ToString() | Should -Be "green"
        }
    }

    Context "ConvertFromObject Tests" {
        It "Should convert from object correctly" {
            $mock = [PSCustomObject]@{
                quote = [PSCustomObject]@{
                    rich_text = @([PSCustomObject]@{
                            type       = "text"
                            text       = @{ content = "Converted quote" }
                            plain_text = "Converted quote"
                        })
                    color     = "yellow"
                }
            }
            $block = [notion_quote_block]::ConvertFromObject($mock)
            $block | Should -BeOfType "notion_quote_block"
            ($block.quote.GetType().Name) | Should -Be "Quote_structure"
            $block.quote.rich_text[0].plain_text | Should -Be "Converted quote"
            $block.quote.color.ToString() | Should -Be "yellow"
        }

        It "Should default to 'default' color if not provided" {
            $mock = [PSCustomObject]@{
                quote = [PSCustomObject]@{
                    rich_text = @([PSCustomObject]@{
                            type       = "text"
                            text       = @{ content = "No color quote" }
                            plain_text = "No color quote"
                        })
                }
            }
            $block = [notion_quote_block]::ConvertFromObject($mock)
            $block.quote.color.ToString() | Should -Be "default"
        }
    }
}
