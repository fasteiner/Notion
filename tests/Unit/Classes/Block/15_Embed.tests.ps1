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

Describe "notion_embed_block Tests" {
    Context "Constructor Tests" {
        It "Should create an empty notion_embed_block" {
            $block = [notion_embed_block]::new()
            $block | Should -BeOfType "notion_embed_block"
            $block.type | Should -Be "embed"
            ($block.embed.GetType().Name) | Should -Be "embed_structure"
            $block.embed.url | Should -BeNullOrEmpty
            $block.embed.caption | Should -BeNullOrEmpty
        }

        It "Should create a notion_embed_block with URL" {
            $block = [notion_embed_block]::new("https://example.com")
            $block.embed.url | Should -Be "https://example.com"
            $block.embed.caption | Should -BeNullOrEmpty
        }

        It "Should create a notion_embed_block with URL and caption" {
            $caption = [rich_text_text]::new("This is a caption")
            $block = [notion_embed_block]::new("https://example.com", @($caption))
            $block.embed.url | Should -Be "https://example.com"
            $block.embed.caption.Count | Should -Be 1
            $block.embed.caption[0].plain_text | Should -Be "This is a caption"
        }
    }

    Context "ConvertFromObject Tests" {
        It "Should convert from object with URL and caption" {
            $mock = [PSCustomObject]@{
                embed = [PSCustomObject]@{
                    url     = "https://notion.so"
                    caption = @([PSCustomObject]@{
                            type       = "text"
                            text       = @{ content = "Caption text" }
                            plain_text = "Caption text"
                        })
                }
            }
            $block = [notion_embed_block]::ConvertFromObject($mock)
            $block | Should -BeOfType "notion_embed_block"
            ($block.embed.GetType().Name) | Should -Be "embed_structure"
            $block.embed.url | Should -Be "https://notion.so"
            $block.embed.caption.Count | Should -Be 1
            $block.embed.caption[0].plain_text | Should -Be "Caption text"
        }

        It "Should convert from object with string URL only" {
            $mock = [PSCustomObject]@{
                embed = "https://notion.so"
            }
            $block = [notion_embed_block]::ConvertFromObject($mock)
            $block.embed.url | Should -Be "https://notion.so"
            $block.embed.caption | Should -BeNullOrEmpty
        }
    }
}
