# FILE: user.Tests.ps1
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


Describe "notion_user class" {

    Context "Constructor and property assignment" {
        It "Default constructor initializes properties to null or default" {
            $user = [notion_user]::new()
            $user.object    | Should -Be "user"
            $user.id        | Should -Be $null
            $user.type      | Should -Be $null
            $user.name      | Should -Be $null
            $user.avatar_url | Should -Be $null
        }

        It "Constructor with object assigns properties correctly" {
            $input = [PSCustomObject]@{
                id         = "abc"
                type       = "person"
                name       = "Alice"
                avatar_url = "http://avatar"
            }
            $user = [notion_user]::new($input)
            $user.id        | Should -Be "abc"
            $user.type      | Should -Be "person"
            $user.name      | Should -Be "Alice"
            $user.avatar_url | Should -Be "http://avatar"
        }

        It "Constructor with id assigns id property" {
            $user = [notion_user]::new("xyz")
            $user.id | Should -Be "xyz"
        }
    }

    Context "CompareTo method" {
        It "Returns 1 when comparing to null" {
            $user = [notion_user]::new()
            $user.CompareTo($null) | Should -Be 1
        }

        It "Throws when comparing to non-notion_user" {
            $user = [notion_user]::new()
            { $user.CompareTo("string") } | Should -Throw "The argument must be a user object."
        }

        It "Returns 0 for equal users" {
            $input = [PSCustomObject]@{
                id = "1"; type = "person"; name = "Bob"; avatar_url = "url"
            }
            $user1 = [notion_user]::new($input)
            $user2 = [notion_user]::new($input)
            $user1.CompareTo($user2) | Should -Be 0
        }

        It "Returns -1 for different users" {
            $user1 = [notion_user]::new([PSCustomObject]@{id = "1"; type = "person"; name = "Bob"; avatar_url = "url" })
            $user2 = [notion_user]::new([PSCustomObject]@{id = "2"; type = "person"; name = "Alice"; avatar_url = "url2" })
            $user1.CompareTo($user2) | Should -Be -1
        }
    }

    Context "Equals method" {
        It "Returns true for equal users" {
            $input = [PSCustomObject]@{
                id = "1"; type = "person"; name = "Bob"; avatar_url = "url"
            }
            $user1 = [notion_user]::new($input)
            $user2 = [notion_user]::new($input)
            $user1.Equals($user2) | Should -Be $true
        }

        It "Returns false for different users" {
            $user1 = [notion_user]::new([PSCustomObject]@{id = "1"; type = "person"; name = "Bob"; avatar_url = "url" })
            $user2 = [notion_user]::new([PSCustomObject]@{id = "2"; type = "person"; name = "Alice"; avatar_url = "url2" })
            $user1.Equals($user2) | Should -Be $false
        }

        It "Returns false when compared to non-notion_user" {
            $user = [notion_user]::new()
            $user.Equals("string") | Should -Be $false
        }
    }

    Context "ConvertFromObject static method" {
        It "Creates a notion_user from a PSCustomObject" {
            $input = [PSCustomObject]@{
                id         = "123"
                type       = "bot"
                name       = "BotUser"
                avatar_url = "http://bot"
            }
            $user = [notion_user]::ConvertFromObject($input)
            $user | Should -BeOfType notion_user
            $user.id        | Should -Be "123"
            $user.type      | Should -Be "bot"
            $user.name      | Should -Be "BotUser"
            $user.avatar_url | Should -Be "http://bot"
        }
    }
}
