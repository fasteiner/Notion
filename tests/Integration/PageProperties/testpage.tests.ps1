Import-Module Pester

BeforeDiscovery {
    $projectPath = "$($PSScriptRoot)/../../../.." | Convert-Path

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

BeforeAll
 {
    if (-not $env:NOTION_BEARER_TOKEN) {
        $BearerTokenFile = ".\BearerToken.$((whoami).split('\')[1]).local.xml"
        #Create Credentials
        # $BearerToken1 = Read-Host -Prompt "Enter your Bearer token (API Key)" -AsSecureString
        # $BearerToken1 | Export-Clixml -Path $BearerTokenFile
        "Importing BearerToken from $BearerTokenFile"
        $BearerToken = Import-Clixml -Path $BearerTokenFile -ErrorAction Stop
    }
    Connect-TSNotion -BearerToken $BearerToken
    $global:TestPageID = $env:TEST_PAGE ?? "55d8f8cf55a4447eb240b8c2a3391034"
}

Describe "Iterate the testpage and check if all objects are converted correctly" {
    It "Should convert the testpage to a notion_page object" {
        $page = Invoke-TSNotionApiCall -uri "/pages/$global:TestPageID" -method GET
        $pageObj = $page | ConvertTo-TSNotionObject
        $page | Should -BeOfType [notion_page]
    }
}
AfterAll{
    Disconnect-TSNotion -Confirm:$false
}
