# FILE: DatabasePropertiesBase.Class.Tests.ps1
Import-Module Pester -DisableNameChecking

BeforeDiscovery {
    $projectPath = "$($PSScriptRoot)/../../../../.." | Convert-Path

    <#
        If the QA tests are run outside of the build script (e.g., with Invoke-Pester)
        the parent scope has not set the variable $ProjectName.
    #>
    if (-not $ProjectName)
    {
        # Assuming project folder name is project name.
        $ProjectName = Get-SamplerProjectName -BuildRoot $projectPath
    }
    Write-Debug "ProjectName: $ProjectName"
    $global:moduleName = $ProjectName

    # Clean re-import of the module under test
    Remove-Module -Name $global:moduleName -Force -ErrorAction SilentlyContinue

    # Import Sampler-built module (no version folder for class tests)
    $mut = Import-Module -Name "$projectPath/output/module/$ProjectName" -Force -ErrorAction Stop -PassThru
}

InModuleScope -ModuleName $global:moduleName {
    Describe "DatabasePropertiesBase Class Tests" {

        Context "Constructors" {
            It "Default ctor should initialize id, name, type as `$null" {
                $obj = [DatabasePropertiesBase]::new()
                $obj.getType().Name | Should -Be "DatabasePropertiesBase"
                $obj.id   | Should -BeNullOrEmpty
                $obj.name | Should -BeNullOrEmpty
            }

            It "Ctor with [string] type should set only .type" {
                $obj = [DatabasePropertiesBase]::new("title")

                $obj.id   | Should -BeNullOrEmpty
                $obj.name | Should -BeNullOrEmpty
                # Some builds type this as enum; accept string assignment then converted by PS
                ($obj.type.ToString()) | Should -Be "title"
            }

            It "Ctor with (id,name,[enum type]) should set all fields" {
                $enumType = [notion_database_property_type] "number"
                $obj = [DatabasePropertiesBase]::new("propId", "Amount", $enumType)

                $obj.id   | Should -Be "propId"
                $obj.name | Should -Be "Amount"
                $obj.type | Should -Be $enumType
                $obj.type.ToString() | Should -Be "number"
            }
        }

        Context "ConvertFromObject dispatch & field mapping" {

            It "Should convert checkbox property and map base fields" {
                $mock = [pscustomobject]@{
                    id   = "chk1"
                    name = "Done"
                    type = "checkbox"
                }

                $res = [DatabasePropertiesBase]::ConvertFromObject($mock)

                $res | Should -BeOfType "notion_checkbox_database_property"
                $res.id   | Should -Be "chk1"
                $res.name | Should -Be "Done"
                $res.type.ToString() | Should -Be "checkbox"
            }

            It "Should convert title property and map base fields" {
                $mock = [pscustomobject]@{
                    id    = "ttl1"
                    name  = "Name"
                    type  = "title"
                    title = @{} # minimal payload for subclass
                }

                $res = [DatabasePropertiesBase]::ConvertFromObject($mock)

                $res | Should -BeOfType "notion_title_database_property"
                $res.id   | Should -Be "ttl1"
                $res.name | Should -Be "Name"
                $res.type.ToString() | Should -Be "title"
            }

            It "Should convert number property and map base fields" {
                $mock = [pscustomobject]@{
                    id     = "num1"
                    name   = "Amount"
                    type   = "number"
                    number = @{ format = "number" }
                }

                $res = [DatabasePropertiesBase]::ConvertFromObject($mock)

                $res | Should -BeOfType "notion_number_database_property"
                $res.id   | Should -Be "num1"
                $res.name | Should -Be "Amount"
                $res.type.ToString() | Should -Be "number"
            }

            It "Should convert relation property and map base fields" {
                $mock = [pscustomobject]@{
                    id       = "rel1"
                    name     = "Related"
                    type     = "relation"
                    relation = @{
                        type          = "dual_property"
                        database_id   = "6c4240a9-a3ce-413e-9fd0-8a51a4d0a49b"
                        dual_property = @{
                            synced_property_name = "Tasks"
                            synced_property_id   = "JU]K"
                        }
                    }
                }
                # Wait-Debugger
                $res = [DatabasePropertiesBase]::ConvertFromObject($mock)

                $res | Should -BeOfType "notion_relation_database_property"
                $res.id   | Should -Be "rel1"
                $res.name | Should -Be "Related"
                $res.type.ToString() | Should -Be "relation"
            }

            It "Should convert select property and map base fields" {
                $mock = [pscustomobject]@{
                    id     = "sel1"
                    name   = "State"
                    type   = "select"
                    select = @{ options = @() }
                }
                $res = [DatabasePropertiesBase]::ConvertFromObject($mock)

                $res | Should -BeOfType "notion_select_database_property"
                $res.id   | Should -Be "sel1"
                $res.name | Should -Be "State"
                $res.type.ToString() | Should -Be "select"
            }
        }

        Context "ConvertFromObject unknown types" {
            It "Should return `$null for unknown type and throw (when ErrorActionPreference is Stop)" {
                $mock = [pscustomobject]@{
                    id   = "x1"
                    name = "Unsupported"
                    type = "nonexistent_type"
                }

                { $ErrorActionPreference = "Stop"
                    $res = [DatabasePropertiesBase]::ConvertFromObject($mock) 
                } | Should -Throw
            }
        }
    }
}
