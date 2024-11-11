#############################################################################################################
# Title: ConvertTo-TSNotionObject.Tests
# Description: 
# 08/2024 Thomas.Subotitsch@base-IT.at
# Minimum Powershell Version: 7
#Requires -Version "7"
#############################################################################################################

Describe "ConvertTo-TSNotionObject" {
    It "should convert a list object correctly" {
        $input = @{
            object  = "list"
            results = @(
                @{ object = "block"; type = "paragraph" },
                @{ object = "block"; type = "heading_1" }
            )
        }
        $result = $input | ConvertTo-TSNotionObject
        $result | Should -Not -BeNullOrEmpty
    }

    # It "should convert a block object with paragraph type correctly" {
    #     $input = @{
    #         object = "block"
    #         type   = "paragraph"
    #     }
    #     $result = $input | ConvertTo-TSNotionObject
    #     $result | Should -Not -BeNullOrEmpty
    # }

    # It "should convert a block object with heading_1 type correctly" {
    #     $input = @{
    #         object = "block"
    #         type   = "heading_1"
    #     }
    #     $result = $input | ConvertTo-TSNotionObject
    #     $result | Should -Not -BeNullOrEmpty
    # }

    It "should convert a page object correctly" {
        $input = @{
            object = "page"
        }
        $result = $input | ConvertTo-TSNotionObject
        $result | Should -Not -BeNullOrEmpty
    }

    # It "should log an error for unsupported object types" {
    #     $input = @{
    #         object = "unsupported_object"
    #     }
    #     $result = $input | ConvertTo-TSNotionObject
    #     $result | Should -BeNullOrEmpty
    # }
}
