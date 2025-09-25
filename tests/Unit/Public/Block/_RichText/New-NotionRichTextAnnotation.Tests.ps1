# FILE: _RichText/New-NotionRichTextAnnotation.Tests.ps1
Import-Module Pester -DisableNameChecking

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

Describe "New-NotionRichTextAnnotation" {
    InModuleScope $moduleName {
        It "Should create a default annotation" {
            $result = New-NotionRichTextAnnotation

            $result | Should -BeOfType "notion_annotation"
            $result.bold | Should -BeFalse
            $result.color | Should -Be ([notion_color]::default)
        }

        It "Should create an annotation from object" {
            $annotations = @{ bold = $true; italic = $true; color = "red" }
            $result = New-NotionRichTextAnnotation -Annotations $annotations

            $result.bold | Should -BeTrue
            $result.italic | Should -BeTrue
            $result.color | Should -Be ([notion_color]::red)
        }

        It "Should create an annotation from switches" {
            $result = New-NotionRichTextAnnotation -Bold -Underline -Color "yellow"

            $result.bold | Should -BeTrue
            $result.underline | Should -BeTrue
            $result.color | Should -Be ([notion_color]::yellow)
        }
    }
}
