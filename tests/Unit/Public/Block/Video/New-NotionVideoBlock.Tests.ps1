# FILE: New-NotionVideoBlock.Tests.ps1
Import-Module Pester -DisableNameChecking

BeforeDiscovery {
    $script:projectPath = "$($PSScriptRoot)/../../../../.." | Convert-Path

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

Describe "New-NotionVideoBlock" {
    InModuleScope $moduleName {
        # Test for InputObject parameter set
        It "Should create a Notion Video block with InputObject" {
            $fileObject = @{ video = @{ type = "external"; external = @{ url = "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_1mb.mp4" }; <#name = "example.mp4";#> caption = "Example Caption" } }
            $result = New-NotionVideoBlock -InputObject $fileObject
            $result | Should -Not -BeNullOrEmpty
            $result | Should -BeOfType "notion_video_block"
            $result.video.type | Should -Be "external"
            $result.video.external.url | Should -Be "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_1mb.mp4"
            # $result.video.name | Should -Be "example.mp4"
            $result.video.caption.plain_text | Should -Be "Example Caption"
        }

        # Test for caption, name, and URL parameter set
        It "Should create a Notion Video block with caption, name, and URL" {
            $result = New-NotionVideoBlock -caption "My Video Caption" <#-name "example.mp4"#> -url "https://example.com/example.mp4"
            $result | Should -Not -BeNullOrEmpty
            $result | Should -BeOfType "notion_video_block"
            $result.video.type | Should -Be "external"
            $result.video.external.url | Should -Be "https://example.com/example.mp4"
            # $result.video.external.name | Should -Be "example.mp4"
            $result.video.caption.plain_text | Should -Be "My Video Caption"
        }

        # Test for invalid parameter combinations
        It "Should throw an error when both InputObject and caption are specified" {
            { New-NotionVideoBlock -InputObject @{ video = @{ type = "external"; external = @{ url = "https://example.com/example.mp4"; name = "example.mp4"; caption = "Example Caption" } } } -caption "My Video" -Name "example.mp4" -url "https://example.com/example.mp4" } | Should -Throw
        }

    }
}
