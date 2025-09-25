# FILE: Image/New-NotionImageBlock.Tests.ps1
Import-Module Pester -DisableNameChecking

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

Describe "New-NotionImageBlock" {
    InModuleScope $moduleName {
        It "Should convert a notion file into an image block" {
            $file = [notion_external_file]::new("Sample", "https://example.com/image.png")
            $result = New-NotionImageBlock -File $file

            $result | Should -BeOfType "notion_image_block"
            $result.type | Should -Be ([notion_blocktype]::image)
            $result.image.external.url | Should -Be "https://example.com/image.png"
        }
    }
}
