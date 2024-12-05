Import-Module Pester

BeforeDiscovery {
    $projectPath = "$($PSScriptRoot)/../../.." | Convert-Path

    <#
        If the QA tests are run outside of the build script (e.g with Invoke-Pester)
        the parent scope has not set the variable $ProjectName.
    #>
    if (-not $ProjectName)
    {
        # Assuming project folder name is project name.
        $ProjectName = Get-SamplerProjectName -BuildRoot $projectPath
    }
    Write-Debug "ProjectName: $ProjectName"
    $global:moduleName = $ProjectName

    Remove-Module -Name $global:moduleName -Force -ErrorAction SilentlyContinue

    $mut = Import-Module -Name "$projectPath/output/module/$ProjectName" -Force -ErrorAction Stop -PassThru

}

Describe "Copy-NotionVariable Tests" {
    InModuleScope $moduleName {
        It "Should copy a simple variable" {
            $sourceVariable = "Hello, World!"
            $result = Copy-NotionVariable -Variable $sourceVariable
            $result | Should -BeExactly $sourceVariable
        }

        It "Should copy an array" {
            $sourceVariable = @(1, 2, 3, 4, 5)
            $result = Copy-NotionVariable -Variable $sourceVariable
            $result | Should -BeExactly $sourceVariable
        }

        It "Should copy a hashtable" {
            $sourceVariable = @{ Key1 = "Value1"; Key2 = "Value2" }
            $result = Copy-NotionVariable -Variable $sourceVariable
            $result | Should -BeExactly $sourceVariable
        }

        It "Should convert to hashtable when asHashtable is specified" {
            $sourceVariable = @{ Key1 = "Value1"; Key2 = "Value2" }
            $result = Copy-NotionVariable -Variable $sourceVariable -asHashtable
            $result | Should -BeOfType "System.Collections.Hashtable"
            $result["Key1"] | Should -BeExactly "Value1"
            $result["Key2"] | Should -BeExactly "Value2"
        }

        It "Should handle nested objects" {
            $sourceVariable = @{ Key1 = @{ SubKey1 = "SubValue1" }; Key2 = "Value2" }
            $result = Copy-NotionVariable -Variable $sourceVariable
            $result | Should -BeExactly $sourceVariable
        }
    }
}
