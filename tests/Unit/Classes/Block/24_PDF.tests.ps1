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

Describe "notion_PDF_block Tests" {
    Context "Constructor Tests" {
        It "Should create an empty notion_PDF_block" {
            $block = [notion_PDF_block]::new()
            $block | Should -BeOfType "notion_PDF_block"
            $block.type | Should -Be "pdf"
            $block.pdf | Should -BeNullOrEmpty
        }

        It "Should create a notion_PDF_block with a notion_file" {
            $file = [notion_external_file]::new("doc.pdf", "Caption", "https://example.com/doc.pdf")
            $block = [notion_PDF_block]::new($file)
            $block.pdf.name | Should -Be "doc.pdf"
            $block.pdf.caption[0].plain_text | Should -Be "Caption"
            $block.pdf.external.url | Should -Be "https://example.com/doc.pdf"
        }

        It "Should create a notion_PDF_block with caption, url, and name" {
            $block = [notion_PDF_block]::new("My Caption", "https://example.com/file.pdf", "file.pdf")
            $block.pdf.name | Should -Be "file.pdf"
            $block.pdf.caption[0].plain_text | Should -Be "My Caption"
            $block.pdf.external.url | Should -Be "https://example.com/file.pdf"
        }
    }

    Context "ConvertFromObject Tests" {
        It "Should convert from object correctly" {
            $mock = [PSCustomObject]@{
                pdf = [PSCustomObject]@{
                    type     = "external"
                    name     = "converted.pdf"
                    caption  = @([PSCustomObject]@{
                            type       = "text"
                            text       = @{ content = "Converted caption" }
                            plain_text = "Converted caption"
                        })
                    external = @{ url = "https://example.com/converted.pdf" }
                }
            }
            $block = [notion_PDF_block]::ConvertFromObject($mock)
            $block | Should -BeOfType "notion_PDF_block"
            ($block.pdf.GetType().Name) | Should -Be "notion_external_file"
            $block.pdf.name | Should -Be "converted.pdf"
            $block.pdf.caption[0].plain_text | Should -Be "Converted caption"
            $block.pdf.external.url | Should -Be "https://example.com/converted.pdf"
        }
    }
}
