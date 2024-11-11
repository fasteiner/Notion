
BeforeDiscovery {
    $projectPath = "$($PSScriptRoot)/../.." | Convert-Path

    <#
        If the QA tests are run outside of the build script (e.g with Invoke-Pester)
        the parent scope has not set the variable $ProjectName.
    #>
    if (-not $ProjectName)
    {
        # Assuming project folder name is project name.
        $ProjectName = Get-SamplerProjectName -BuildRoot $projectPath
    }

    $script:moduleName = $ProjectName

    Remove-Module -Name $script:moduleName -Force -ErrorAction SilentlyContinue

    $mut = Import-Module -Name "$projectPath/output/module/$ProjectName" -Force -ErrorAction Stop -PassThru
}

BeforeAll {
    #Import-Module -Name "$PSScriptRoot/../../..\output\TSNotion.psd1" -Force
    $standardOutput = [System.IO.StringWriter]::new()
    $BearerToken = $env:NOTION_BEARER_TOKEN | ConvertTo-SecureString -AsPlainText -Force
}

Describe "Connect-TSNotion" {
    Context "When providing valid Bearer token and URL" {
        It "Should connect to the Notion API" {
            # Arrange
            $standardOutput.GetStringBuilder().Clear() | Out-Null
            
            $notionURL = "https://api.notion.com/v1"
            $expectedResult = @{
                url     = $notionURL
                version = '2022-06-28'
            }

            # Act
            $result = Connect-TSNotion -BearerToken $BearerToken -notionURL $notionURL > $standardOutput

            # Assert
            $result | Should -Be $expectedResult
            $standardOutput | Should -Contain "Successfully connected to Notion API."
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
            $result = Connect-TSNotion -BearerToken $BearerToken -notionURL $notionURL

            # Assert
            $result | Should -Be $expectedResult
        }
    }

    Context "When providing an invalid Bearer token" {
        It "Should fail to connect to the Notion API" {
            # Arrange
            $BearerToken = "invalidBearerToken"
            $notionURL = "https://api.notion.com/v1"

            # Act
            $result = Connect-TSNotion -BearerToken $BearerToken -notionURL $notionURL

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
            $result = Connect-TSNotion -BearerToken $BearerToken -notionURL $notionURL
    
            # Assert
            $result | Should -Be $expectedResult
        }
    }
    
    Context "When providing an invalid Bearer token" {
        It "Should fail to connect to the Notion API" {
            # Arrange
            $BearerToken = "invalidBearerToken"
            $notionURL = "https://api.notion.com/v1"
    
            # Act
            $result = Connect-TSNotion -BearerToken $BearerToken -notionURL $notionURL
    
            # Assert
            $result | Should -Be $null
        }
    }
    
    Context "When providing an empty Bearer token" {
        It "Should fail to connect to the Notion API" {
            # Arrange
            $BearerToken = ""
            $notionURL = "https://api.notion.com/v1"
    
            # Act
            $result = Connect-TSNotion -BearerToken $BearerToken -notionURL $notionURL
    
            # Assert
            $result | Should -Be $null
        }
    }
    
    Context "When providing a null Bearer token" {
        It "Should fail to connect to the Notion API" {
            # Arrange
            $BearerToken = $null
            $notionURL = "https://api.notion.com/v1"
    
            # Act
            $result = Connect-TSNotion -BearerToken $BearerToken -notionURL $notionURL
    
            # Assert
            $result | Should -Be $null
        }
    }
    
    Context "When providing an invalid URL" {
        It "Should fail to connect to the Notion API" {
            # Arrange
            
            $notionURL = "invalidURL"
    
            # Act
            $result = Connect-TSNotion -BearerToken $BearerToken -notionURL $notionURL
    
            # Assert
            $result | Should -Be $null
        }
    }
    
    Context "When providing a null URL" {
        It "Should fail to connect to the Notion API" {
            # Arrange
            
            $notionURL = $null
    
            # Act
            $result = Connect-TSNotion -BearerToken $BearerToken -notionURL $notionURL
    
            # Assert
            $result | Should -Be $null
        }
    }
    
    Context "When providing an empty URL" {
        It "Should fail to connect to the Notion API" {
            # Arrange
            
            $notionURL = ""
    
            # Act
            $result = Connect-TSNotion -BearerToken $BearerToken -notionURL $notionURL
    
            # Assert
            $result | Should -Be $null
        }
    }
}
