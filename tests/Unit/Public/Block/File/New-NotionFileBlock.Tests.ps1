# FILE: File/New-NotionFileBlock.Tests.ps1
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

Describe "New-NotionFileBlock" {
    InModuleScope $moduleName {
        It "Should create an empty file block" {
            $result = New-NotionFileBlock

            $result | Should -BeOfType "notion_file_block"
            $result.type | Should -Be ([notion_blocktype]::file)
        }

        It "Should create an external file block" {
            $result = New-NotionFileBlock -Name "example.pdf" -Caption "Example" -Url "https://example.com/example.pdf"

            $result | Should -BeOfType "notion_file_block"
            $result.file.external.url | Should -Be "https://example.com/example.pdf"
            $result.file.caption[0].plain_text | Should -Be "Example"
        }

        It "Should create a hosted file block with expiry" {
            $expiry = Get-Date "2025-12-31T23:59:59Z"
            $expectedExpiry = ConvertTo-NotionFormattedDateTime -InputDate $expiry
            $result = New-NotionFileBlock -Name "report.pdf" -Caption "Report" -Url "https://example.com/report.pdf" -ExpiryTime $expiry

            $result | Should -BeOfType "notion_file_block"
            $result.file.file.url | Should -Be "https://example.com/report.pdf"
            $result.file.file.expiry_time | Should -Be $expectedExpiry
        }

        It "Should create a file block from object" {
            $externalFile = [notion_external_file]::new("example.pdf", "https://example.com/example.pdf")
            $result = New-NotionFileBlock -File $externalFile

            $result | Should -BeOfType "notion_file_block"
            $result.file.external.url | Should -Be "https://example.com/example.pdf"
        }
    }
}
