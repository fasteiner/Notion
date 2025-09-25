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

Describe "notion_image_block Tests" {
    Context "Constructor Tests" {
        It "Should create an empty notion_image_block" {
            $block = [notion_image_block]::new()
            $block | Should -BeOfType "notion_image_block"
            $block.type | Should -Be "image"
            $block.image | Should -BeNullOrEmpty
            $block.caption | Should -BeNullOrEmpty
        }

        It "Should create a notion_image_block with file only" {
            $file = [notion_external_file]::new("image.png", "Caption from file", "https://example.com/image.png")
            $block = [notion_image_block]::new($file)
            $block.image.name | Should -Be "image.png"
            $block.image.caption[0].plain_text | Should -Be "Caption from file"
            $block.caption | Should -BeNullOrEmpty
        }

        It "Should create a notion_image_block with file and caption" {
            $file = [notion_external_file]::new("image.png", "Image Caption", "https://example.com/image.png")
            $block = [notion_image_block]::new($file)
            $block.image.name | Should -Be "image.png"
            $block.image.caption | Should -Not -BeNullOrEmpty
            $block.image.caption[0].plain_text | Should -Be "Image Caption"
        }
    }

    Context "ConvertFromObject Tests" {
        It "Should convert from object with image and caption" {
            $mock = [PSCustomObject]@{
                image   = [PSCustomObject]@{
                    type     = "external"
                    name     = "converted.png"
                    external = @{ url = "https://example.com/converted.png" }
                    caption = @([PSCustomObject]@{
                            type       = "text"
                            text       = @{ content = "Converted caption" }
                            plain_text = "Converted caption"
                        })
                }
            }
            $block = [notion_image_block]::ConvertFromObject($mock)
            $block | Should -BeOfType "notion_image_block"
            $block.image.name | Should -Be "converted.png"
            $block.image.external.url | Should -Be "https://example.com/converted.png"
            $block.image.caption | Should -Not -BeNullOrEmpty
            $block.image.caption[0].plain_text | Should -Be "Converted caption"
        }
    }
}
