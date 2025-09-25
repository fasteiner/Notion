# FILE: New-NotionPdfBlock.Tests.ps1
Import-Module Pester -DisableNameChecking

BeforeDiscovery {
    $script:projectPath = "$($PSScriptRoot)/../../../../.." | Convert-Path


    if (-not $ProjectName)
    {
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
        # Test for InputObject parameter set
        It "Should create a Notion PDF block with InputObject" {
            $fileObject = @{ pdf = @{ type = "external"; external = @{ url = "https://example.com/example.pdf" }; <#name = "example.pdf";#> caption = "Example Caption" } }
            $result = New-NotionPdfBlock -InputObject $fileObject
            $result | Should -Not -BeNullOrEmpty
            $result | Should -BeOfType "notion_PDF_block"
            $result.pdf.type | Should -Be "external"
            $result.pdf.external.url | Should -Be "https://example.com/example.pdf"
            # $result.pdf.name | Should -Be "example.pdf"
            $result.pdf.caption.plain_text | Should -Be "Example Caption"
        }

        # Test for caption, name, and URL parameter set
        It "Should create a Notion PDF block with caption, name, and URL" {
            $result = New-NotionPdfBlock -caption "My PDF Caption" <#-name "example.pdf"#> -url "https://example.com/example.pdf"
            $result | Should -Not -BeNullOrEmpty
            $result | Should -BeOfType "notion_PDF_block"
            $result.pdf.type | Should -Be "external"
            $result.pdf.external.url | Should -Be "https://example.com/example.pdf"
            # $result.pdf.external.name | Should -Be "example.pdf"
            $result.pdf.caption.plain_text | Should -Be "My PDF Caption"
        }

        # Test for invalid parameter combinations
        It "Should throw an error when both InputObject and caption are specified" {
            { New-NotionPdfBlock -InputObject @{ pdf = @{ type = "external"; external = @{ url = "https://example.com/example.pdf"; name = "example.pdf"; caption = "Example Caption" } } } -caption "My PDF" -Name "example.pdf" -url "https://example.com/example.pdf" } | Should -Throw
        }

    }
}
