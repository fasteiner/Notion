# Import the module containing the notion_databaseproperties class
Import-Module Pester -DisableNameChecking

BeforeDiscovery {
    $projectPath = "$($PSScriptRoot)/../../../../.." | Convert-Path

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
InModuleScope -ModuleName $global:moduleName {
    Describe "notion_databaseproperties Tests" {
        Context "Constructor Tests" {
            It "Should create a notion_databaseproperties" {
                $dbProperties = [notion_databaseproperties]::new()
                $dbProperties.GetType().Name | Should -Be "notion_databaseproperties"
                $dbProperties | Should -BeOfType "hashtable"
            }
        }
    
        Context "Add Method Tests" {
            It "Should add a valid DatabasePropertiesBase object" {
                $dbProperties = [notion_databaseproperties]::new()
                $checkboxProperty = [notion_checkbox_database_property]::new()
            
                { $dbProperties.Add("checkboxField", $checkboxProperty) } | Should -Not -Throw
                $dbProperties["checkboxField"] | Should -Be $checkboxProperty
                $dbProperties["checkboxField"].GetType().BaseType.Name | Should -Be "DatabasePropertiesBase"
                $dbProperties["checkboxField"].type | Should -Be "checkbox"
            }
        
            It "Should throw error when adding invalid value type" {
                $dbProperties = [notion_databaseproperties]::new()
                $invalidValue = "InvalidString"
            
                { $ErrorActionPreference = "Stop" ; $dbProperties.Add("testKey", $invalidValue) } | Should -Throw
            }
        
            It "Should not allow null values" {
                $dbProperties = [notion_databaseproperties]::new()
            
                { $dbProperties.Add("testKey", $null) } | Should -Not -Throw
                { $ErrorActionPreference = "Stop"; $dbProperties.Add("testKey", $null) } | Should -Throw
                $dbProperties["testKey"] | Should -Be $null
            }
        }
    
        Context "ConvertFromObject Tests" {
            It "Should convert from hashtable correctly" {
                $mockHashtable = @{
                    "Vorname"     = [PSCustomObject]@{ title = @{}; id = "title"; name = "Vorname"; type = "title" }
                    "Ordernumber" = [PSCustomObject]@{ number = @{ format = "number" }; id = "C%3E%3FU"; name = "Ordernumber"; type = "number" }
                    "Anwesend"    = [PSCustomObject]@{ checkbox = @{}; id = "ch%3Di"; name = "Anwesend"; type = "checkbox" }
                }
            
                $dbProperties = [notion_databaseproperties]::ConvertFromObject($mockHashtable)
            
                $dbProperties | Should -BeOfType "notion_databaseproperties"
                $dbProperties.Count | Should -Be 3
                $dbProperties.ContainsKey("Vorname") | Should -Be $true
                $dbProperties.ContainsKey("Ordernumber") | Should -Be $true
                $dbProperties.ContainsKey("Anwesend") | Should -Be $true
            }
        
            It "Should convert from PSCustomObject correctly" {
                $mockObject = [PSCustomObject]@{
                    Vorname   = [PSCustomObject]@{ title = @{}; id = "title"; name = "Vorname"; type = "title" }
                    Telefon   = [PSCustomObject]@{ phone_number = @{}; id = "INcy"; name = "Telefon"; type = "phone_number" }
                    Orderdate = [PSCustomObject]@{ date = @{}; id = "%5Byc%3C"; name = "Orderdate"; type = "date" }
                    "E-Mail"  = [PSCustomObject]@{ email = @{}; id = "dBvC"; name = "E-Mail"; type = "email" }
                }
            
                $dbProperties = [notion_databaseproperties]::ConvertFromObject($mockObject)
            
                $dbProperties | Should -BeOfType "notion_databaseproperties"
                $dbProperties.Count | Should -Be 4
                $dbProperties.ContainsKey("Vorname") | Should -Be $true
                $dbProperties.ContainsKey("Telefon") | Should -Be $true
                $dbProperties.ContainsKey("Orderdate") | Should -Be $true
                $dbProperties.ContainsKey("E-Mail") | Should -Be $true
            }
        
            It "Should handle empty input" {
                $emptyHashtable = @{}
                $dbProperties = [notion_databaseproperties]::ConvertFromObject($emptyHashtable)
            
                $dbProperties | Should -BeOfType "notion_databaseproperties"
                $dbProperties.Count | Should -Be 0
            }
        }
    
        Context "Inheritance Tests" {
            It "Should inherit from hashtable" {
                $dbProperties = [notion_databaseproperties]::new()
                $dbProperties | Should -BeOfType "hashtable"
            }
        
            It "Should support hashtable operations" {
                $dbProperties = [notion_databaseproperties]::new()
                $mockProperty = [PSCustomObject]@{}
                $mockProperty.PSObject.TypeNames.Insert(0, 'DatabasePropertiesBase')
            
                $dbProperties["testKey"] = $mockProperty
                $dbProperties.ContainsKey("testKey") | Should -Be $true
                $dbProperties.Keys.Count | Should -Be 1
            }
        }
    }
}
