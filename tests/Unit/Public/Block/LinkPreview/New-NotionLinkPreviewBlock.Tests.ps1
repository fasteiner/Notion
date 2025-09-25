# FILE: LinkPreview/New-NotionLinkPreviewBlock.Tests.ps1
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

Describe "New-NotionLinkPreviewBlock" {
    InModuleScope $moduleName {
        It "Should throw because link preview blocks cannot be created" {
            {
                $ErrorActionPreference = 'Stop'
                New-NotionLinkPreviewBlock
            } | Should -Throw -ErrorMessage "link_preview" 
        }
    }
}
