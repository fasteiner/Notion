Import-Module Pester -DisableNameChecking

# BeforeDiscovery block to set up module import for testing
BeforeDiscovery {
    # Get the root path of the project
    $projectPath = "$($PSScriptRoot)/../../../.." | Convert-Path

    # Get the project name if not already set
    if (-not $ProjectName)
    {
        $ProjectName = Get-SamplerProjectName -BuildRoot $projectPath
    }
    Write-Debug "ProjectName: $ProjectName"
    $global:moduleName = $ProjectName

    # Ensure a clean module environment
    Remove-Module -Name $global:moduleName -Force -ErrorAction SilentlyContinue
    Import-Module -Name "$projectPath/output/module/$ProjectName" -Force -ErrorAction Stop -PassThru
}

# Tests for the notion_status class
# This class represents a status property value in Notion, which includes a color, ID, and name
Describe "notion_status Tests" {
    # Test all constructor overloads
    Context "Constructor Tests" {
        # Test the default constructor with no parameters
        It "Should create an empty notion_status" {
            $status = [notion_status]::new()
            $status | Should -BeOfType "notion_status"
            $status.name | Should -BeNullOrEmpty
            $status.color | Should -Be "default" # Default color is set
            $status.id | Should -BeNullOrEmpty
        }
        
        # Test constructor with just the name parameter
        It "Should create from name only" {
            $status = [notion_status]::new("In Progress")
            $status | Should -BeOfType "notion_status"
            $status.name | Should -Be "In Progress"
            $status.color | Should -Be "default" # Default color when not specified
            $status.id | Should -BeNullOrEmpty
        }

        # Test constructor with color and name parameters
        It "Should create from color and name" {
            $status = [notion_status]::new("yellow", "Done")
            $status.name | Should -Be "Done"
            $status.color | Should -Be "yellow" # Custom color is set
            $status.id | Should -BeNullOrEmpty
        }

        # Test constructor with all parameters: color, id, and name
        It "Should create from color, id and name" {
            $status = [notion_status]::new("purple", "12345678-abcd-efgh-ijkl-1234567890ab", "Blocked")
            $status.name | Should -Be "Blocked"
            $status.color | Should -Be "purple" 
            $status.id | Should -Be "12345678-abcd-efgh-ijkl-1234567890ab" # ID is set
        }
    }

    # Test the static method for converting from a PSCustomObject
    Context "ConvertFromObject Tests" {
        # Test conversion from a PSCustomObject with all properties
        It "Should convert from object correctly" {
            # Create a mock object that simulates a Notion API response
            $mock = [PSCustomObject]@{
                color = "blue"
                id    = "98765432-abcd-efgh-ijkl-0987654321ba"
                name  = "Not Started"
            }
            
            # Convert the mock to a notion_status object
            $status = [notion_status]::ConvertFromObject($mock)
            
            # Verify all properties were properly converted
            $status | Should -BeOfType "notion_status"
            $status.name | Should -Be "Not Started"
            $status.color | Should -Be "blue"
            $status.id | Should -Be "98765432-abcd-efgh-ijkl-0987654321ba"
        }
    }
}
