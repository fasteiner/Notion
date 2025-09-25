# FILE: _RichText/New-NotionRichText.Tests.ps1
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

Describe "New-NotionRichText" {
    InModuleScope $moduleName {
        It "Should create a rich text object with text" {
            $result = New-NotionRichText -Text "Hello"

            $result | Should -Not -BeNullOrEmpty
            $result[0] | Should -BeOfType "rich_text_text"
            $result[0].plain_text | Should -Be "Hello"
        }

        It "Should create rich text with annotations and link" {
            $annotations = New-NotionRichTextAnnotation -Bold
            $result = New-NotionRichText -Text "Link" -Annotations $annotations -Link "https://example.com"

            $result[0].annotations.bold | Should -BeTrue
            $result[0].href | Should -Be "https://example.com"
        }

        It "Should convert markdown text" {
            $result = New-NotionRichText -MarkdownText "**Bold**"

            $result | Should -Not -BeNullOrEmpty
            $result[0].annotations.bold | Should -BeTrue
            $result[0].plain_text | Should -Be "Bold"
        }
    }
}
