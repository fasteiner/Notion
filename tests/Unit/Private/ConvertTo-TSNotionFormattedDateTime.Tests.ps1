# FILE: ConvertTo-NotionFormattedDateTime.Tests.ps1
Import-Module Pester

BeforeDiscovery {
    $projectPath = "$($PSScriptRoot)/../../.." | Convert-Path

    <#
        If the QA tests are run outside of the build script (e.g with Invoke-Pester)
        the parent scope has not set the variable $ProjectName.
    #>
    if (-not $ProjectName)
    {
        # Assuming project folder name is project name.
        $ProjectName = Get-SamplerProjectName -BuildRoot $projectPath
    }
    Write-Debug "ProjectName: $ProjectName"
    $global:moduleName = $ProjectName

    Remove-Module -Name $global:moduleName -Force -ErrorAction SilentlyContinue

    $mut = Import-Module -Name "$projectPath/output/module/$ProjectName" -Force -ErrorAction Stop -PassThru
}

Describe "ConvertTo-NotionFormattedDateTime" {
    InModuleScope $moduleName {
        # Test for valid datetime input
        It "should convert a valid datetime object to the specified format" {
            $inputDate = Get-Date "2023-10-01T12:34:56Z"
            $expected = "2023-10-01T12:34:56.000Z"
            $result = ConvertTo-NotionFormattedDateTime -InputDate $inputDate
            $result | Should -BeExactly $expected
        }
    
        # Test for valid string input
        It "should convert a valid string date to the specified format" {
            $inputDate = "2023-10-01T12:34:56Z"
            $expected = "2023-10-01T12:34:56.000Z"
            $result = ConvertTo-NotionFormattedDateTime -InputDate $inputDate
            $result | Should -BeExactly $expected
        }
    
        # Test for invalid string input
        It "should return $null and log an error for an invalid string date" {
            $inputDate = "invalid-date"
            $result = ConvertTo-NotionFormattedDateTime -InputDate $inputDate -ErrorAction SilentlyContinue
            $result | Should -Be $null
            {ConvertTo-NotionFormattedDateTime -InputDate $inputDate -ErrorAction Stop} | Should -Throw
        }
    
        # Test for unsupported input type
        It "should return $null and log an error for unsupported input type" {
            $inputDate = @{}
            $result = ConvertTo-NotionFormattedDateTime -InputDate $inputDate -ErrorAction SilentlyContinue
            $result | Should -Be $null
            {ConvertTo-NotionFormattedDateTime -InputDate $inputDate -ErrorAction Stop} | Should -Throw
        }
    
    }
}
