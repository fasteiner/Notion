
BeforeDiscovery {
    $script:projectPath = "$($PSScriptRoot)/../../.." | Convert-Path

    <#
        If the QA tests are run outside of the build script (e.g with Invoke-Pester)
        the parent scope has not set the variable $ProjectName.
    #>
    if (-not $ProjectName)
    {
        # Assuming project folder name is project name.
        $ProjectName = Get-SamplerProjectName -BuildRoot $script:projectPath
    }
    Write-Debug "ProjectName: $ProjectName"
    $global:moduleName = $ProjectName
    Set-Alias -Name gitversion -Value dotnet-gitversion
    $script:version = (gitversion /showvariable MajorMinorPatch)

    Remove-Module -Name $global:moduleName -Force -ErrorAction SilentlyContinue
    
    $mut = Import-Module -Name "$script:projectPath/output/module/$ProjectName/$script:version/$ProjectName.psd1" -Force -ErrorAction Stop -PassThru

    $script:capturedMessages = @()
}

BeforeAll {
    #Import-Module -Name "$PSScriptRoot/../../..\output\Notion.psd1" -Force
    $standardOutput = [System.IO.StringWriter]::new()
    $BearerToken = $null
    if (-not $env:NOTION_BEARER_TOKEN)
    {
        $BearerTokenFile = ".\BearerToken.$((whoami).split('\')[1]).local.xml"
        #Create Credentials
        # $BearerToken1 = Read-Host -Prompt "Enter your Bearer token (API Key)" -AsSecureString
        # $BearerToken1 | Export-Clixml -Path $BearerTokenFile
        "Importing BearerToken from $BearerTokenFile"
        $BearerToken = Import-Clixml -Path $BearerTokenFile -ErrorAction Stop
    }
    else
    {
        $BearerToken = $env:NOTION_BEARER_TOKEN | ConvertTo-SecureString -AsPlainText -Force
    }
}

Describe "Connect-Notion" {
    Context "When providing valid Bearer token and URL" {
        It "Should connect to the Notion API" {
            # Arrange
            
            
            $notionURL = "https://api.notion.com/v1"

            # Act
            $result = Connect-Notion -BearerToken $BearerToken -notionURL $notionURL

            # Assert
            $result.url | Should -Be $notionURL
            $result.version | Should -Be '2022-06-28'
        }
    }

    Context "When not providing the API version" {
        It "Should use the default API version" {
            # Arrange
            
            $notionURL = "https://api.notion.com/v1"
            $expectedResult = @{
                url     = $notionURL
                version = '2022-06-28'
            }

            # Act
            $result = Connect-Notion -BearerToken $BearerToken -notionURL $notionURL


            # Assert
            $result.url | Should -Be $expectedResult.url
            $result.version | Should -Be $expectedResult.version
            
        }
    }

    Context "When providing an invalid Bearer token" {
        It "Should fail to connect to the Notion API" {
            # Arrange
            $BearerToken = "invalidBearerToken"
            $notionURL = "https://api.notion.com/v1"

            # Act
            {Connect-Notion -BearerToken $BearerToken -notionURL $notionURL} | Should -Throw

            # Assert
            $result | Should -Be $null
        }
    }

    Context "When not providing the API version" {
        It "Should use the default API version" {
            # Arrange
            
            $notionURL = "https://api.notion.com/v1"
            $expectedResult = @{
                url     = $notionURL
                version = '2022-06-28'
            }
    
            # Act
            $result = Connect-Notion -BearerToken $BearerToken -notionURL $notionURL
    
            # Assert
            $result.url | Should -Be $expectedResult.url
            $result.version | Should -Be $expectedResult.version
            
        }
    }
    
    
    Context "When providing an empty Bearer token" {
        It "Should fail to connect to the Notion API" {
            # Arrange
            $BearerToken = ""
            $notionURL = "https://api.notion.com/v1"
    
            # Act
            {Connect-Notion -BearerToken $BearerToken -notionURL $notionURL} | Should -Throw
    
        }
    }
    
    Context "When providing a null Bearer token" {
        It "Should fail to connect to the Notion API" {
            # Arrange
            $BearerToken = $null
            $notionURL = "https://api.notion.com/v1"
    
            # Act
            {Connect-Notion -BearerToken $BearerToken -notionURL $notionURL} | Should -Throw

        }
    }
    
    Context "When providing an invalid URL" {
        It "Should fail to connect to the Notion API" {
            # Arrange
            
            $notionURL = "invalidURL"
    
            # Act
            {Connect-Notion -BearerToken $BearerToken -notionURL $notionURL -ErrorAction Stop} | Should -Throw
    
            }
    }
    
    Context "When providing a null URL" {
        It "Should not fail to connect to the Notion API" {
            # Arrange
            
            $notionURL = $null
    
            $result = Connect-Notion -BearerToken $BearerToken -notionURL $notionURL -ErrorAction SilentlyContinue

            # Assert
            $result | Should -Not -BeNullOrEmpty
        }
    }
    
    Context "When providing an empty URL" {
        It "Should fail to connect to the Notion API" {
            # Arrange
            
            $notionURL = ""
    
            # Act
            { Connect-Notion -BearerToken $BearerToken -notionURL $notionURL -ErrorAction Stop } | Should -Throw
        }
    }
}
