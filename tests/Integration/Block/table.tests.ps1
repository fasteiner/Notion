Import-Module Pester -DisableNameChecking

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

Describe "Create a Callout Block on a Notion Page" {
    It "Should create a callout block with rich text, icon, and color" {

        $children = @()
        # Table data for Notion
        $tableData = @(
            @{
                "Name" = "Person"
                "Description" = "A class representing a person with properties and methods."
                "Properties" = "Name (string), Age (int)"
                "Methods" = "Greet()"
            },
            @{
                "Name" = "Car"
                "Description" = "A class representing a car with properties and methods."
                "Properties" = "Make (string), Model (string), Year (int)"
                "Methods" = "Start(), Stop()"
            }
        )
        $children += New-NotionTableBlock -TableData $tableData
        $ParentObject = New-NotionParent -Type "page_id" -Id $global:TestPageID

        $NewPageProps = @{
            Parent = $ParentObject
            Title = "Table Block Test Page"
            Children = $children
        }

        $page = New-NotionPage @NewPageProps -ErrorAction Stop

        # Upload the content to Notion
        # Attention: The Integration must be added to the parent page (or database) to be able to create a new page
        # Otherwise you get: HTTP error 404: Could not find object. Make sure the relevant pages and databases a

        #verify that the page contains the callout block
        $pageBlocks = Get-NotionPageChildren -PageID $page.id -ErrorAction Stop

        $pageBlocks | Should -Contain $calloutBlock
        $pageBlocks | Should -HaveCount 1
        $pageBlocks[0].type | Should -Be "callout"
        $pageBlocks[0].callout.rich_text[0].plain_text | Should -Be "This is a callout"
        $pageBlocks[0].callout.icon.emoji | Should -Be "🔥"
        $pageBlocks[0].callout.color.ToString() | Should -Be "yellow"

        Remove-NotionPage -PageID $page.id -Confirm:$false -ErrorAction Stop

    }
}
AfterAll {
    Disconnect-Notion -Confirm:$false
}
