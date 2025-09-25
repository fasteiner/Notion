# FILE: Paragraph/New-NotionParagraphBlock.Tests.ps1
Import-Module Pester

BeforeDiscovery {
    $script:projectPath = "$($PSScriptRoot)/../../../../.." | Convert-Path

    if (-not $ProjectName) {
        $ProjectName = Get-SamplerProjectName -BuildRoot $script:projectPath
    }
    Write-Debug "ProjectName: $ProjectName"
    $global:moduleName = $ProjectName
    Set-Alias -Name gitversion -Value dotnet-gitversion
    $script:version = (gitversion /showvariable MajorMinorPatch)

    Remove-Module -Name $global:moduleName -Force -ErrorAction SilentlyContinue

    $mut = Import-Module -Name "$script:projectPath/output/module/$ProjectName/$script:version/$ProjectName.psd1" -Force -ErrorAction Stop -PassThru
}

Describe "New-NotionParagraphBlock" {
    InModuleScope $moduleName {
        It "Should create an empty paragraph block" {
            $result = New-NotionParagraphBlock

            $result | Should -BeOfType "notion_paragraph_block"
            $result.type | Should -Be ([notion_blocktype]::paragraph)
            $result.paragraph.rich_text | Should -BeNullOrEmpty
        }

        It "Should create a paragraph block with rich text" {
            $richText = New-NotionRichText -Text "Hello World"
            $result = New-NotionParagraphBlock -RichText $richText

            $result.paragraph.rich_text[0].plain_text | Should -Be "Hello World"
            $result.paragraph.color | Should -Be ([notion_color]::default)
        }

        It "Should create a paragraph block with rich text and color" {
            $richText = New-NotionRichText -Text "Colored" 
            $result = New-NotionParagraphBlock -RichText $richText -Color yellow

            $result.paragraph.rich_text[0].plain_text | Should -Be "Colored"
            $result.paragraph.color | Should -Be ([notion_color]::yellow)
        }
    }
}
