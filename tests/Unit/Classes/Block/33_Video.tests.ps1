Import-Module Pester

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

Context "notion_video_block" {
    It "should create an instance with default constructor" {
        $instance = [notion_video_block]::new()
        $instance | Should -BeOfType [notion_video_block]
        $instance.type | Should -Be "video"
    }

    It "should create an instance with URL constructor (external file)" {
        $url = "https://example.com/video.mp4"
        $instance = [notion_video_block]::new($url)
        $instance.video.type | Should -Be "external"
        $instance.video.external.getType().Name | Should -Be "notion_external_file_structure"
        $instance.video.external.url | Should -Be $url
        $instance.video | Should -BeOfType [notion_file]
    }



    It "should create an instance with filetype, URL, and expiry time (hosted file)" {
        $filetype = [notion_filetype]::file
        $url = "https://example.com/video.mp4"
        $expiry = (Get-Date).AddDays(1)
        $instance = [notion_video_block]::new($filetype, $url, $expiry)
        $instance.video | Should -BeOfType [notion_hosted_file]
        $instance.video.type | Should -Be "file"
        $instance.video.file.url | Should -Be $url
        $instance.video.file.expiry_time | Should -Not -BeNullOrEmpty
    }

    It "should convert from object correctly (hosted file)" {
        $mockObject = [PSCustomObject]@{
            video = [PSCustomObject]@{
                type    = "file"
                name    = "example.mp4"
                caption = @()
                file    = [PSCustomObject]@{
                    url         = "https://example.com/video.mp4"
                    expiry_time = (Get-Date).AddDays(1).ToString("o")
                }
            }
        }

        $converted = [notion_video_block]::ConvertFromObject($mockObject)
        $converted | Should -BeOfType [notion_video_block]
        $converted.video | Should -BeOfType [notion_hosted_file]
        $converted.video.file.url | Should -Be $mockObject.video.file.url
        $converted.video.name | Should -Be "example.mp4"
    }

    It "should convert from object correctly (external file)" {
        $mockObject = [PSCustomObject]@{
            video = [PSCustomObject]@{
                type     = "external"
                name     = "external_video.mp4"
                caption  = @()
                external = [PSCustomObject]@{
                    url = "https://cdn.example.com/video.mp4"
                }
            }
        }

        $converted = [notion_video_block]::ConvertFromObject($mockObject)
        $converted | Should -BeOfType [notion_video_block]
        $converted.video | Should -BeOfType [notion_external_file]
        $converted.video.external.url | Should -Be $mockObject.video.external.url
        $converted.video.name | Should -Be "external_video.mp4"
    }
}
