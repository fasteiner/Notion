# FILE: Video/New-NotionVideoBlock.Tests.ps1
Import-Module Pester

BeforeDiscovery {
    $script:projectPath = "$($PSScriptRoot)/../../../../.." | Convert-Path

    if (-not $ProjectName) {
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
        It "Should create a video block from input object" {
            $input = @{ video = @{ type = "external"; external = @{ url = "https://example.com/video.mp4" } } }
            $result = New-NotionVideoBlock -InputObject $input

            $result | Should -BeOfType "notion_video_block"
            $result.video.external.url | Should -Be "https://example.com/video.mp4"
        }

        It "Should create a video block from caption and url" {
            $result = New-NotionVideoBlock -caption "Demo video" -url "https://example.com/video.mp4"

            $result | Should -BeOfType "notion_video_block"
            $result.video.caption[0].plain_text | Should -Be "Demo video"
            $result.video.external.url | Should -Be "https://example.com/video.mp4"
        }
    }
}
