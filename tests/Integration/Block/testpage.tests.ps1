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

BeforeAll {
    if (-not $env:NOTION_BEARER_TOKEN)
    {
        $BearerTokenFile = ".\BearerToken.$((whoami).split('\')[1]).local.xml"
        #Create Credentials
        # $BearerToken1 = Read-Host -Prompt "Enter your Bearer token (API Key)" -AsSecureString
        # $BearerToken1 | Export-Clixml -Path $BearerTokenFile
        "Importing BearerToken from $BearerTokenFile"
        $BearerToken = Import-Clixml -Path $BearerTokenFile -ErrorAction Stop
    }
    Connect-Notion -BearerToken $BearerToken
    $global:TestPageID = $env:TEST_PAGE ?? "5158893eac8b4f719c8b49b99596adb7"
}

Describe "Iterate the testpage and check if all objects are converted correctly" {
    It "Should convert the page correctly" {
        $childrenRaw = Invoke-NotionApiCall -Uri "/blocks/$global:TestPageID/children" -Method GET
        $i = 0
        foreach ($child in $childrenRaw)
        {
            Write-Debug "Checking child block of type $($child.type) at index $($i)"
            
            if ($child.type -eq "unsupported")
            {
                $message = ""
                $type = ""
                if ([System.Enum]::TryParse([notion_blocktype], $child.type, [ref]$type))
                {
                    $message = "Block type `"$($child.type)`" not implemented yet"
                }
                else
                {
                    $message = "Unknown block type: `"$($child.type)`""
                }
                { $child | ConvertTo-NotionObject -ErrorAction Stop } | Should -Throw $message
            }
            else
            {
                $childObj = $child | ConvertTo-NotionObject
                $childObj.type | Should -Be $child.type
                $className = "notion_$($child.type)"
                if (-not $className.EndsWith("_block"))
                {
                    $className += "_block"
                }
                $childObj | Should -BeOfType "$className"
            }
            $i++
        }
    }
}
AfterAll {
    Disconnect-Notion -Confirm:$false
}
