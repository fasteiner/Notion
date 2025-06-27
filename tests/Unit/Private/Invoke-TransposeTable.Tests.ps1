# FILE: Invoke-TransposeTable.Tests.ps1
Import-Module Pester

BeforeDiscovery {
    $script:projectPath = "$($PSScriptRoot)/../../.." | Convert-Path

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

Describe "Invoke-TransposeTable" {
    InModuleScope $moduleName {
        It "should transpose a 2D array (matrix)" {
            $matrix = @(
                @(1, 2, 3),
                @(4, 5, 6)
            )
            $expected = @(
                @(1, 4),
                @(2, 5),
                @(3, 6)
            )
            $result = Invoke-TransposeTable -InputObject $matrix
            $result | Should -BeOfType [array]
            $result.Count | Should -BeExactly 3
            $result[0] | Should -Be $expected[0]
            $result[1] | Should -Be $expected[1]
            $result[2] | Should -Be $expected[2]
        }

        It "should throw an error for empty arrays, as transposing an empty array is not possible" {
            $matrix = @()
            {Invoke-TransposeTable -InputObject $matrix} | Should -Throw
        }

    }
}
