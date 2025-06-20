# FILE: New-NotionCalloutBlock.Tests.ps1
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

Describe "notion_parent class" {
    Context "Create static method" {
        It "Creates a notion_database_parent when type is 'database_id'" {
            $parent = [notion_parent]::Create("database_id", "db123")
            $parent | Should -BeOfType "notion_database_parent"
            $parent.type | Should -Be "database_id"
            $parent.database_id | Should -Be "db123"
        }
        It "Creates a notion_page_parent when type is 'page_id'" {
            $parent = [notion_parent]::Create("page_id", "pg456")
            $parent | Should -BeOfType "notion_page_parent"
            $parent.type | Should -Be "page_id"
            $parent.page_id | Should -Be "pg456"
        }
        It "Creates a notion_workspace_parent when type is 'workspace'" {
            $parent = [notion_parent]::Create("workspace", $null)
            $parent | Should -BeOfType "notion_workspace_parent"
            $parent.type | Should -Be "workspace"
        }
        It "Creates a notion_block_parent when type is 'block_id'" {
            $parent = [notion_parent]::Create("block_id", "blk789")
            $parent | Should -BeOfType "notion_block_parent"
            $parent.type | Should -Be "block_id"
            $parent.block_id | Should -Be "blk789"
        }
        It "Throws error for unknown type" {
                        { [notion_parent]::Create("unknown_type", "id") } | Should -Throw -ExceptionType System.Management.Automation.RuntimeException
        }
    }

    Context "ConvertFromObject static method" {
        It "Converts object with type 'database_id'" {
            $obj = [PSCustomObject]@{ type = "database_id"; database_id = "db123" }
            $parent = [notion_parent]::ConvertFromObject($obj)
            $parent | Should -BeOfType notion_database_parent
            $parent.database_id | Should -Be "db123"
        }
        It "Converts object with type 'page_id'" {
            $obj = [PSCustomObject]@{ type = "page_id"; page_id = "pg456" }
            $parent = [notion_parent]::ConvertFromObject($obj)
            $parent | Should -BeOfType notion_page_parent
            $parent.page_id | Should -Be "pg456"
        }
        It "Converts object with type 'workspace'" {
            $obj = [PSCustomObject]@{ type = "workspace" }
            $parent = [notion_parent]::ConvertFromObject($obj)
            $parent | Should -BeOfType notion_workspace_parent
        }
        It "Converts object with type 'block_id'" {
            $obj = [PSCustomObject]@{ type = "block_id"; block_id = "blk789" }
            $parent = [notion_parent]::ConvertFromObject($obj)
            $parent | Should -BeOfType notion_block_parent
            $parent.block_id | Should -Be "blk789"
        }
        It "Throws error for unknown type" {
            $obj = [PSCustomObject]@{ type = "unknown_type" }
            { [notion_parent]::ConvertFromObject($obj) } | Should -Throw
        }
    }
}
