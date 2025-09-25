# FILE: Pdf/New-NotionPdfBlock.Tests.ps1
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

Describe "New-NotionPdfBlock" {
    InModuleScope $moduleName {
        It "Should create a PDF block from input object" {
            $fileObject = @{ pdf = @{ type = "external"; external = @{ url = "https://example.com/example.pdf" }; caption = "Example Caption" } }
            $result = New-NotionPdfBlock -InputObject $fileObject

            $result | Should -Not -BeNullOrEmpty
            $result | Should -BeOfType "notion_PDF_block"
            $result.pdf.type | Should -Be "external"
            $result.pdf.external.url | Should -Be "https://example.com/example.pdf"
        }

        It "Should create a PDF block with caption and url" {
            $result = New-NotionPdfBlock -caption "My PDF Caption" -url "https://example.com/example.pdf"

            $result | Should -Not -BeNullOrEmpty
            $result | Should -BeOfType "notion_PDF_block"
            $result.pdf.type | Should -Be "external"
            $result.pdf.external.url | Should -Be "https://example.com/example.pdf"
            $result.pdf.caption[0].plain_text | Should -Be "My PDF Caption"
        }
    }
}
