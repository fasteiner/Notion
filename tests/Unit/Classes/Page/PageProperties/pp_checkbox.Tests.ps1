# FILE: pp_checkbox.Tests.ps1
Import-Module Pester

BeforeDiscovery {
    $script:projectPath = "$($PSScriptRoot)/../../../../.." | Convert-Path

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

Describe "notion_checkbox_page_property" {
    Context "Constructor" {
        It "Should create an instance with checkbox = $true" {
            $obj = [notion_checkbox_page_property]::new($true)
            $obj | Should -BeOfType notion_checkbox_page_property
            $obj.checkbox | Should -Be $true
            $obj.type | Should -Be "checkbox"
        }

        It "Should create an instance with checkbox = $false" {
            $obj = [notion_checkbox_page_property]::new($false)
            $obj.checkbox | Should -Be $false
        }
    }

    Context "ConvertFromObject" {
        It "Should convert from object with checkbox = $true" {
            $input = [PSCustomObject]@{ checkbox = $true }
            $obj = [notion_checkbox_page_property]::ConvertFromObject($input)
            $obj | Should -BeOfType notion_checkbox_page_property
            $obj.checkbox | Should -Be $true
        }

        It "Should convert from object with checkbox = $false" {
            $input = [PSCustomObject]@{ checkbox = $false }
            $obj = [notion_checkbox_page_property]::ConvertFromObject($input)
            $obj.checkbox | Should -Be $false
        }
    }
}
