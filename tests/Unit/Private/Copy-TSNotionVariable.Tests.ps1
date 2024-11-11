#############################################################################################################
# Title: Copy-TSNotionVariable.Tests
# Description: 
# 08/2024 Thomas.Subotitsch@base-IT.at
# Minimum Powershell Version: 7
#Requires -Version "7"
#############################################################################################################

Describe "Copy-TSNotionVariable Tests" {
    It "Should copy a simple variable" {
        $sourceVariable = "Hello, World!"
        $result = Copy-TSNotionVariable -Variable $sourceVariable
        $result | Should -BeExactly $sourceVariable
    }

    It "Should copy an array" {
        $sourceVariable = @(1, 2, 3, 4, 5)
        $result = Copy-TSNotionVariable -Variable $sourceVariable
        $result | Should -BeExactly $sourceVariable
    }

    It "Should copy a hashtable" {
        $sourceVariable = @{ Key1 = "Value1"; Key2 = "Value2" }
        $result = Copy-TSNotionVariable -Variable $sourceVariable
        $result | Should -BeExactly $sourceVariable
    }

    It "Should convert to hashtable when asHashtable is specified" {
        $sourceVariable = @{ Key1 = "Value1"; Key2 = "Value2" }
        $result = Copy-TSNotionVariable -Variable $sourceVariable -asHashtable
        $result | Should -BeOfType "System.Collections.Hashtable"
        $result["Key1"] | Should -BeExactly "Value1"
        $result["Key2"] | Should -BeExactly "Value2"
    }

    It "Should handle nested objects" {
        $sourceVariable = @{ Key1 = @{ SubKey1 = "SubValue1" }; Key2 = "Value2" }
        $result = Copy-TSNotionVariable -Variable $sourceVariable
        $result | Should -BeExactly $sourceVariable
    }
}
