Import-Module Pester -DisableNameChecking

BeforeDiscovery {
    $projectPath = "$($PSScriptRoot)/../../../.." | Convert-Path

    if (-not $ProjectName)
    {
        $ProjectName = Get-SamplerProjectName -BuildRoot $projectPath
    }
    Write-Debug "ProjectName: $ProjectName"
    $global:moduleName = $ProjectName

    Remove-Module -Name $global:moduleName -Force -ErrorAction SilentlyContinue
    $mut = Import-Module -Name "$projectPath/output/module/$ProjectName" -Force -ErrorAction Stop -PassThru
}

Describe "notion_select Tests" {
    Context "Constructor Tests" {
        It "Should create an empty notion_select" {
            $select = [notion_select]::new()
            $select | Should -BeOfType "notion_select"
            $select.name | Should -BeNullOrEmpty
            $select.id | Should -BeNullOrEmpty
            $select.color | Should -Be "default"
        }

        It "Should create from name only" {
            $select = [notion_select]::new("Option Name")
            $select.name | Should -Be "Option Name"
            $select.color | Should -Be "default"
            $select.id | Should -BeNullOrEmpty
        }

        It "Should create from color and name" {
            $select = [notion_select]::new("yellow", "Option Name")
            $select.name | Should -Be "Option Name"
            $select.color | Should -Be "yellow"
            $select.id | Should -BeNullOrEmpty
        }

        It "Should create from color, id and name" {
            $select = [notion_select]::new("purple", "12345678-abcd-efgh-ijkl-1234567890ab", "Option Name")
            $select.name | Should -Be "Option Name"
            $select.color | Should -Be "purple"
            $select.id | Should -Be "12345678-abcd-efgh-ijkl-1234567890ab"
        }
    }

    Context "ConvertFromObject Tests" {
        It "Should convert from object correctly" {
            $mock = [PSCustomObject]@{
                color = "blue"
                id    = "98765432-abcd-efgh-ijkl-0987654321ba"
                name  = "Converted Option"
            }
            $select = [notion_select]::ConvertFromObject($mock)
            $select | Should -BeOfType "notion_select"
            $select.name | Should -Be "Converted Option"
            $select.color | Should -Be "blue"
            $select.id | Should -Be "98765432-abcd-efgh-ijkl-0987654321ba"
        }
    }
}
