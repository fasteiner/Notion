# Import Pester (test framework) – the module under test is imported in BeforeDiscovery
Import-Module Pester -DisableNameChecking

BeforeDiscovery {
    # Resolve project root (4 levels up from this test file)
    $projectPath = "$($PSScriptRoot)/../../../../.." | Convert-Path

    <#
        If tests are run outside the build script (e.g. Invoke-Pester directly),
        the parent scope might not have set $ProjectName.
    #>
    if (-not $ProjectName)
    {
        # Assume the project folder name equals the project/module name.
        $ProjectName = Get-SamplerProjectName -BuildRoot $projectPath
    }
    Write-Debug "ProjectName: $ProjectName"
    $global:moduleName = $ProjectName

    # Ensure a clean module context before importing
    Remove-Module -Name $global:moduleName -Force -ErrorAction SilentlyContinue

    # Import the built module from output
    $mut = Import-Module -Name "$projectPath/output/module/$ProjectName" -Force -ErrorAction Stop -PassThru
}
InModuleScope -ModuleName $global:moduleName {

    Describe "notion_database_relation_base Tests" {
    
        Context "Constructor Tests" {
        
            It "Should create instance with type successfully" {
                # Create a new instance with type
                $instance = [notion_database_relation_base]::new("single_property")
            
                # Verify that the instance was created
                $instance | Should -Not -BeNullOrEmpty
                $instance | Should -BeOfType [notion_database_relation_base]
            
                # Verify the properties
                $instance.type | Should -Be "single_property"
                $instance.database_id | Should -BeNullOrEmpty
            }
        
            It "Should create instance with database_id and type successfully" {
                # Create a new instance with database_id and type
                $testDatabaseId = "test-database-id"
                $instance = [notion_database_relation_base]::new($testDatabaseId, "dual_property")
            
                # Verify that the instance was created
                $instance | Should -Not -BeNullOrEmpty
                $instance | Should -BeOfType [notion_database_relation_base]
            
                # Verify the properties
                $instance.type | Should -Be "dual_property"
                $instance.database_id | Should -Be $testDatabaseId
            }
        }
    
        Context "ConvertFromObject Tests" {
        
            It "Should convert single_property type successfully" {
                # Create a test hashtable for single_property
                $testData = @{
                    database_id     = "test-db-id"
                    type            = "single_property"
                    single_property = @{
                        id                   = "test-single-id"
                        synced_property_id   = "test-synced-id"
                        synced_property_name = "Test Single Property"
                    }
                }
            
                # Convert the hashtable to an object
                $result = [notion_database_relation_base]::ConvertFromObject($testData)
            
                # Verify the result
                $result | Should -Not -BeNullOrEmpty
                $result | Should -BeOfType [notion_database_single_relation]
                $result.type | Should -Be "single_property"
                $result.database_id | Should -Be "test-db-id"
            }
        
            It "Should convert dual_property type successfully" {
                # Create a test hashtable for dual_property
                $testData = @{
                    database_id   = "test-db-id-dual"
                    type          = "dual_property"
                    dual_property = @{
                        id                   = "test-dual-id"
                        synced_property_id   = "test-synced-id-dual"
                        synced_property_name = "Test Dual Property"
                    }
                }
            
                # Convert the hashtable to an object
                $result = [notion_database_relation_base]::ConvertFromObject($testData)
            
                # Verify the result
                $result | Should -Not -BeNullOrEmpty
                $result | Should -BeOfType [notion_database_dual_relation]
                $result.type | Should -Be "dual_property"
                $result.database_id | Should -Be "test-db-id-dual"
            }
        }
    }

    Describe "notion_database_single_relation Tests" {
    
        Context "Constructor Tests" {
        
            It "Should create default instance successfully" {
                # Create a new instance with the default constructor
                $instance = [notion_database_single_relation]::new()
            
                # Verify that the instance was created
                $instance | Should -Not -BeNullOrEmpty
                $instance | Should -BeOfType [notion_database_single_relation]
            
                # Verify the inherited properties
                $instance.type | Should -Be "single_property"
                $instance.database_id | Should -BeNullOrEmpty
            
                # Verify the specific properties
                $instance.single_property | Should -Not -BeNullOrEmpty
                $instance.single_property.getType().Name | Should -Be "notion_relation_database_property_structure"
            }
        
            It "Should create instance with all parameters successfully" {
                # Create a new instance with all parameters
                $testDatabaseId = "test-database-id"
                $testSyncedPropertyId = "test-synced-id"
                $testSyncedPropertyName = "Test Synced Property"
            
                $instance = [notion_database_single_relation]::new($testDatabaseId, $testSyncedPropertyId, $testSyncedPropertyName)
            
                # Verify that the instance was created
                $instance | Should -Not -BeNullOrEmpty
                $instance | Should -BeOfType [notion_database_single_relation]
            
                # Verify the properties
                $instance.type | Should -Be "single_property"
                $instance.database_id | Should -Be $testDatabaseId
                $instance.single_property | Should -Not -BeNullOrEmpty
            }
        }
    
        Context "Inheritance Tests" {
        
            It "Should inherit from notion_database_relation_base" {
                # Create an instance
                $instance = [notion_database_single_relation]::new()
            
                # Verify the inheritance
                $instance | Should -BeOfType [notion_database_relation_base]
            
                # Verify the inherited properties
                $instance.type | Should -Be "single_property"
            }
        }
    }

    Describe "notion_database_dual_relation Tests" {
    
        Context "Constructor Tests" {
        
            It "Should create default instance successfully" {
                # Create a new instance with the default constructor
                $instance = [notion_database_dual_relation]::new()
            
                # Verify that the instance was created
                $instance | Should -Not -BeNullOrEmpty
                $instance | Should -BeOfType [notion_database_dual_relation]
            
                # Verify the inherited properties
                $instance.type | Should -Be "dual_property"
                $instance.database_id | Should -BeNullOrEmpty
            
                # Verify the specific properties
                $instance.dual_property | Should -Not -BeNullOrEmpty
                $instance.dual_property.getType().Name | Should -Be "notion_relation_database_property_structure"
            }
        
            It "Should create instance with all parameters successfully" {
                # Create a new instance with all parameters
                $testDatabaseId = "test-database-id-dual"
                $testSyncedPropertyId = "test-synced-id-dual"
                $testSyncedPropertyName = "Test Synced Property Dual"
            
                $instance = [notion_database_dual_relation]::new($testDatabaseId, $testSyncedPropertyId, $testSyncedPropertyName)
            
                # Verify that the instance was created
                $instance | Should -Not -BeNullOrEmpty
                $instance | Should -BeOfType [notion_database_dual_relation]
            
                # Verify the properties
                $instance.type | Should -Be "dual_property"
                $instance.database_id | Should -Be $testDatabaseId
                $instance.dual_property | Should -Not -BeNullOrEmpty
            }
        }
    
        Context "Inheritance Tests" {
        
            It "Should inherit from notion_database_relation_base" {
                # Create an instance
                $instance = [notion_database_dual_relation]::new()
            
                # Verify the inheritance
                $instance | Should -BeOfType [notion_database_relation_base]
            
                # Verify the inherited properties
                $instance.type | Should -Be "dual_property"
            }
        }
    }

    Describe "notion_relation_database_property Tests" {
    
        Context "Constructor Tests" {
        
            It "Should create instance with null relation successfully" {
                # Create a new instance with null
                $instance = [notion_relation_database_property]::new($null)
            
                # Verify that the instance was created
                $instance | Should -Not -BeNullOrEmpty
                $instance | Should -BeOfType [notion_relation_database_property]
            
                # Verify the properties
                $instance.type | Should -Be "relation"
                $instance.relation | Should -BeNullOrEmpty
            }
        
            It "Should create instance with relation object successfully" {
                # Create a Relation
                $relation = [notion_database_single_relation]::new()
            
                # Create a new instance with the Relation
                $instance = [notion_relation_database_property]::new($relation)
            
                # Verify that the instance was created
                $instance | Should -Not -BeNullOrEmpty
                $instance | Should -BeOfType [notion_relation_database_property]
            
                # Verify the properties
                $instance.type | Should -Be "relation"
                $instance.relation | Should -Be $relation
            }
        
            It "Should create single_property relation instance successfully" {
                # Create a new instance for single_property
                $testDatabaseId = "test-database-id"
                $testSyncedPropertyId = "test-synced-id"
                $testSyncedPropertyName = "Test Synced Property"
            
                $instance = [notion_relation_database_property]::new($testDatabaseId, "single_property", $testSyncedPropertyId, $testSyncedPropertyName)
            
                # Verify that the instance was created
                $instance | Should -Not -BeNullOrEmpty
                $instance | Should -BeOfType [notion_relation_database_property]
            
                # Verify the properties
                $instance.type | Should -Be "relation"
                $instance.relation | Should -Not -BeNullOrEmpty
                $instance.relation | Should -BeOfType [notion_database_single_relation]
                $instance.relation.type | Should -Be "single_property"
            }
        
            It "Should create dual_property relation instance successfully" {
                # Create a new instance for dual_property
                $testDatabaseId = "test-database-id-dual"
                $testSyncedPropertyId = "test-synced-id-dual"
                $testSyncedPropertyName = "Test Synced Property Dual"
            
                $instance = [notion_relation_database_property]::new($testDatabaseId, "dual_property", $testSyncedPropertyId, $testSyncedPropertyName)
            
                # Verify that the instance was created
                $instance | Should -Not -BeNullOrEmpty
                $instance | Should -BeOfType [notion_relation_database_property]
            
                # Verify the properties
                $instance.type | Should -Be "relation"
                $instance.relation | Should -Not -BeNullOrEmpty
                $instance.relation | Should -BeOfType [notion_database_dual_relation]
                $instance.relation.type | Should -Be "dual_property"
            }
        }
        
        Context "ConvertFromObject Tests" {
        
            It "Should convert single_property relation successfully" {
                # Create a test hashtable for single_property relation
                $testData = @{
                    type     = "relation"
                    relation = @{
                        database_id     = "test-db-id"
                        type            = "single_property"
                        single_property = @{
                            id                   = "test-single-id"
                            synced_property_id   = "test-synced-id"
                            synced_property_name = "Test Single Property"
                        }
                    }
                }
            
                # Convert the hashtable to an object
                $result = [notion_relation_database_property]::ConvertFromObject($testData)
            
                # Verify the result
                $result | Should -Not -BeNullOrEmpty
                $result | Should -BeOfType [notion_relation_database_property]  # Note: ConvertFromObject returns relation object directly
                $result.relation | Should -BeOfType [notion_database_single_relation]
            }
        
            It "Should convert dual_property relation successfully" {
                # Create a test hashtable for dual_property relation
                $testData = @{
                    type     = "relation"
                    relation = @{
                        database_id   = "test-db-id-dual"
                        type          = "dual_property"
                        dual_property = @{
                            id                   = "test-dual-id"
                            synced_property_id   = "test-synced-id-dual"
                            synced_property_name = "Test Dual Property"
                        }
                    }
                }
            
                # Convert the hashtable to an object
                $result = [notion_relation_database_property]::ConvertFromObject($testData)
            
                # Verify the result
                $result | Should -Not -BeNullOrEmpty
                $result | Should -BeOfType [notion_relation_database_property]
                $result.relation | Should -BeOfType [notion_database_dual_relation]  # Note: ConvertFromObject returns relation object directly
            }
        }
    
        Context "Inheritance Tests" {
        
            It "Should inherit from DatabasePropertiesBase" {
                # Create an instance with parameters
                $relation = [notion_database_single_relation]::new("test-db-id", "test-sync-id", "Test Name")
                $instance = [notion_relation_database_property]::new($relation)
            
                # Check inheritance
                $instance.GetType().Name | Should -Be "notion_relation_database_property"
                $instance -is [DatabasePropertiesBase] | Should -Be $true
            
                # Check inherited properties
                $instance.type | Should -Be "relation"
            }
        
            It "Should have correct type property from base class" {
                # Create an instance with parameters
                $relation = [notion_database_single_relation]::new("test-db-id", "test-sync-id", "Test Name")
                $instance = [notion_relation_database_property]::new($relation)
            
                # Check that the type is correctly set
                $instance.type | Should -Be "relation"
                $instance.type.GetType().Name | Should -Be "notion_database_property_type"
            }
        }
    }
}
