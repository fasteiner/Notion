Describe "notion_icon Tests" {
    BeforeDiscovery {
        $script:projectPath = "$($PSScriptRoot)/../../../.." | Convert-Path

        if (-not $ProjectName)
        {
            $ProjectName = Get-SamplerProjectName -BuildRoot $script:projectPath
        }

        Write-Debug "ProjectName: $ProjectName"
        $global:moduleName = $ProjectName
        Set-Alias -Name gitversion -Value dotnet-gitversion
        $script:version = (gitversion /showvariable MajorMinorPatch)

        Remove-Module -Name $global:moduleName -Force -ErrorAction SilentlyContinue
        $mut = Import-Module -Name "$script:projectPath/output/module/$ProjectName/$script:version/$ProjectName.psd1" -Force -ErrorAction Stop -PassThru
    }

    Context "Create method (single value)" {
        It "should return null when input is null" {
            $result = [notion_icon]::Create($null)
            $result | Should -BeNullOrEmpty
        }

        It "should return the same object if input is already a notion_icon" {
            $emoji = [notion_emoji]::new("🔥")
            $result = [notion_icon]::Create($emoji)
            $result | Should -Be $emoji
        }

        It "should create a notion_emoji from emoji string" {
            $result = [notion_icon]::Create("🎉")
            $result | Should -BeOfType [notion_emoji]
            $result.emoji | Should -Be "🎉"
        }

        It "should create a notion_external_file from URL string" {
            $url = "https://example.com/icon.png"
            $result = [notion_icon]::Create($url)
            $result | Should -BeOfType [notion_external_file]
            $result.external.url | Should -Be $url
        }

        It "should convert from object with type 'emoji'" {
            $mock = [PSCustomObject]@{
                type  = "emoji"
                emoji = "💡"
            }
            $result = [notion_icon]::Create($mock)
            $result | Should -BeOfType [notion_emoji]
            $result.emoji | Should -Be "💡"
        }

        It "should convert from object with type 'external'" {
            $mock = [PSCustomObject]@{
                type     = "external"
                external = @{ url = "https://example.com/icon.png" }
            }
            $result = [notion_icon]::Create($mock)
            $result | Should -BeOfType [notion_external_file]
            $result.external.url | Should -Be "https://example.com/icon.png"
        }

        It "should convert from object with type 'file'" {
            $mock = [PSCustomObject]@{
                type = "file"
                file = @{ url = "https://cdn.notion.so/icon.png"; expiry_time = (Get-Date).ToString("o") }
            }
            $result = [notion_icon]::Create($mock)
            $result | Should -BeOfType [notion_hosted_file]
            $result.file.url | Should -Be "https://cdn.notion.so/icon.png"
        }
    }

    Context "Create method (url + expiry)" {
        It "should create a notion_hosted_file when both url and expiry are provided" {
            $url = "https://cdn.notion.so/icon.png"
            $expiry = (Get-Date).AddHours(1)
            $result = [notion_icon]::Create($url, $expiry)
            $result | Should -BeOfType [notion_hosted_file]
            $result.file.url | Should -Be $url
        }

        It "should create a notion_external_file when only url is provided" {
            $url = "https://example.com/icon.png"
            $result = [notion_icon]::Create($url, $null)
            $result | Should -BeOfType [notion_external_file]
            $result.external.url | Should -Be $url
        }

        It "should write an error when neither url nor expiry is provided" {
            $error.Clear()
            $ErrorActionPreference = "SilentlyContinue"
            $null = [notion_icon]::Create($null, $null)
            $error[0].Exception.Message | Should -Match "You must provide either a URL or an ExpiryTime"
            $ErrorActionPreference = "Stop"
        }
    }

    Context "ConvertFromObject method" {
        It "should return null when input is null" {
            $result = [notion_icon]::ConvertFromObject($null)
            $result | Should -BeNullOrEmpty
        }

        It "should convert emoji object" {
            $mock = [PSCustomObject]@{
                type  = "emoji"
                emoji = "📘"
            }
            $result = [notion_icon]::ConvertFromObject($mock)
            $result | Should -BeOfType [notion_emoji]
            $result.emoji | Should -Be "📘"
        }

        It "should convert external file object" {
            $mock = [PSCustomObject]@{
                type     = "external"
                external = @{ url = "https://example.com/icon.png" }
            }
            $result = [notion_icon]::ConvertFromObject($mock)
            $result | Should -BeOfType [notion_external_file]
            $result.external.url | Should -Be "https://example.com/icon.png"
        }

        It "should convert hosted file object" {
            $mock = [PSCustomObject]@{
                type = "file"
                file = @{ url = "https://cdn.notion.so/icon.png"; expiry_time = (Get-Date).ToString("o") }
            }
            $result = [notion_icon]::ConvertFromObject($mock)
            $result | Should -BeOfType [notion_hosted_file]
            $result.file.url | Should -Be "https://cdn.notion.so/icon.png"
        }

        It "should write an error for unknown type" {
            $mock = [PSCustomObject]@{
                type = "unknown"
            }
            $error.Clear()
            $ErrorActionPreference = "SilentlyContinue"
            $null = [notion_icon]::ConvertFromObject($mock)
            $error[0].Exception.Message | Should -Match "Unknown icon type"
            $ErrorActionPreference = "Stop"
        }

        It "should treat links as external files" {
            $result = [notion_icon]::ConvertFromObject("https://example.com/icon.png")
            $result | Should -BeOfType [notion_external_file]
        }

        It "should handle emoji string as emoji" {
            $result = [notion_icon]::ConvertFromObject("📘")
            $result | Should -BeOfType [notion_emoji]
            $result.emoji | Should -Be "📘"
        }

    }
}
