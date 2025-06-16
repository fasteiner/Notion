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

Describe "notion_link_preview_block Tests" {
    Context "Constructor Tests" {
        It "Should create an empty notion_link_preview_block" {
            $block = [notion_link_preview_block]::new()
            $block | Should -BeOfType "notion_link_preview_block"
            $block.type | Should -Be "link_preview"
            $block.link_preview | Should -BeNullOrEmpty
        }

        It "Should create a notion_link_preview_block with URL" {
            $block = [notion_link_preview_block]::new("https://example.com")
            $block.link_preview | Should -Not -BeNullOrEmpty
            ($block.link_preview.GetType().Name) | Should -Be "link_preview_structure"
            $block.link_preview.url | Should -Be "https://example.com"
        }
    }

    Context "ConvertFromObject Tests" {
        It "Should convert from object correctly" {
            $mock = [PSCustomObject]@{
                link_preview = [PSCustomObject]@{
                    url = "https://notion.so"
                }
            }
            $block = [notion_link_preview_block]::ConvertFromObject($mock)
            $block | Should -BeOfType "notion_link_preview_block"
            ($block.link_preview.GetType().Name) | Should -Be "link_preview_structure"
            $block.link_preview.url | Should -Be "https://notion.so"
        }
    }
}
