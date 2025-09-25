BeforeDiscovery {
    $projectPath = "$($PSScriptRoot)\..\.." | Convert-Path

    <#
        If the QA tests are run outside of the build script (e.g with Invoke-Pester)
        the parent scope has not set the variable $ProjectName.
    #>
    if (-not $ProjectName)
    {
        # Assuming project folder name is project name.
        $ProjectName = Get-SamplerProjectName -BuildRoot $projectPath
    }

    $global:moduleName = $ProjectName

    Remove-Module -Name $global:moduleName -Force -ErrorAction SilentlyContinue

    $mut = Get-Module -Name $global:moduleName -ListAvailable |
        Select-Object -First 1 |
            Import-Module -Force -ErrorAction Stop -PassThru
}

Describe "Module Function Name Prefix Validation" {
    It "All exported functions should follow the naming convention Verb-PrefixFunctionName>" {
        # Get all exported functions from the module
        $exportedFunctions = (Get-Command -Module $global:moduleName).Where({$_.Source -eq $global:moduleName}).Name

        # Define the regex pattern with named groups
        $namingPattern = "^(?<Verb>[A-Za-z]+)-(?<Prefix>$global:moduleName)(?<FunctionName>[A-Za-z]*)$"

        # Iterate through each function and validate the naming convention
        # $DebugPreference = 'Continue'
        foreach ($functionName in $exportedFunctions) {
            Write-Debug "Validating function: $functionName"

            $functionName | Should -Match $namingPattern
        }
    }
}
