# FILE: emoji.tests.ps1
Import-Module Pester -DisableNameChecking

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

Describe "notion_emoji class" {

    Context "Constructor" {
        It "Creates an instance with no emoji" {
            $obj = [notion_emoji]::new()
            $obj | Should -BeOfType notion_emoji
            $obj.emoji | Should -BeNullOrEmpty
            $obj.type | Should -Be "emoji"
        }

        It "Creates an instance with an emoji" {
            $obj = [notion_emoji]::new("😀")
            $obj.emoji | Should -Be "😀"
            $obj.type | Should -Be "emoji"
        }
    }

    Context "ConvertFromObject static method" {
        It "Returns the same object if already notion_emoji" {
            $obj = [notion_emoji]::new("😎")
            $result = [notion_emoji]::ConvertFromObject($obj)
            $result | Should -Be $obj
        }

        It "Creates from string" {
            $result = [notion_emoji]::ConvertFromObject("🔥")
            $result | Should -BeOfType notion_emoji
            $result.emoji | Should -Be "🔥"
        }

        It "Creates from object with emoji property" {
            $input = [PSCustomObject]@{ emoji = "💡" }
            $result = [notion_emoji]::ConvertFromObject($input)
            $result | Should -BeOfType notion_emoji
            $result.emoji | Should -Be "💡"
        }
    }
}
