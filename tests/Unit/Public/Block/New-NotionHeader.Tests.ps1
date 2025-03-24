# FILE: New-NotionHeader.Tests.ps1
Import-Module Pester

BeforeDiscovery {
    $script:projectPath = "$($PSScriptRoot)/../../../.." | Convert-Path

    <#
        If the QA tests are run outside of the build script (e.g with Invoke-Pester)
        the parent scope has not set the variable $ProjectName.
    #>
    if (-not $ProjectName)
    {
        # Assuming project folder name is project name.
        $ProjectName = Get-SamplerProjectName -BuildRoot $script:projectPath
    }
    Write-Debug "ProjectName: $ProjectName"
    $global:moduleName = $ProjectName
    Set-Alias -Name gitversion -Value dotnet-gitversion
    $script:version = (gitversion /showvariable MajorMinorPatch)

    Remove-Module -Name $global:moduleName -Force -ErrorAction SilentlyContinue

    $mut = Import-Module -Name "$script:projectPath/output/module/$ProjectName/$script:version/$ProjectName.psd1" -Force -ErrorAction Stop -PassThru
}

Describe "New-NotionHeader" {
    InModuleScope $moduleName {
        # Test for level validation
        It "Should throw an error when Level is out of range" {
            { New-NotionHeader -Text "Test Header" -Level 4 } | Should -Throw
            { New-NotionHeader -Text "Test Header" -Level 0 } | Should -Throw
        }

        # Test for default parameters
        It "Should create a Notion header with default parameters" {
            $result = New-NotionHeader -Text "Test Header" -Level 1
            $result | Should -Not -BeNullOrEmpty
            $result | Should -BeOfType "notion_heading_block"
        }

        # Test for custom color
        It "Should allow setting a custom color" {
            $result = New-NotionHeader -Text "Colored Header" -Color "blue" -Level 2
            $result.heading_2.Color | Should -Be "blue"
        }

        # Test for toggleable property
        It "Should correctly set toggleable property" {
            $result = New-NotionHeader -Text "Toggleable Header" -Level 3 -is_toggleable $true
            $result.heading_3.is_toggleable | Should -Be $true
        }
    }
}
