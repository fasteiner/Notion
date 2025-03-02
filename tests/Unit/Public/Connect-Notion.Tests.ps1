
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

}

BeforeAll {
    #Import-Module -Name "$PSScriptRoot/../../..\output\Notion.psd1" -Force
    $standardOutput = [System.IO.StringWriter]::new()
    $BearerToken = $env:NOTION_BEARER_TOKEN | ConvertTo-SecureString -AsPlainText -Force
}

Describe "Connect-Notion" {
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
            $result = Connect-Notion -BearerToken $BearerToken -notionURL $notionURL > $standardOutput

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
            $result = Connect-Notion -BearerToken $BearerToken -notionURL $notionURL

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
            $result = Connect-Notion -BearerToken $BearerToken -notionURL $notionURL

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
            $result | Should -Be $expectedResult
        }
    }
    
    Context "When providing an invalid Bearer token" {
        It "Should fail to connect to the Notion API" {
            # Arrange
            $BearerToken = "invalidBearerToken"
            $notionURL = "https://api.notion.com/v1"
    
            # Act
            $result = Connect-Notion -BearerToken $BearerToken -notionURL $notionURL
    
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
            $result = Connect-Notion -BearerToken $BearerToken -notionURL $notionURL
    
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
            $result = Connect-Notion -BearerToken $BearerToken -notionURL $notionURL
    
            # Assert
            $result | Should -Be $null
        }
    }
    
    Context "When providing an invalid URL" {
        It "Should fail to connect to the Notion API" {
            # Arrange
            
            $notionURL = "invalidURL"
    
            # Act
            $result = Connect-Notion -BearerToken $BearerToken -notionURL $notionURL
    
            # Assert
            $result | Should -Be $null
        }
    }
    
    Context "When providing a null URL" {
        It "Should fail to connect to the Notion API" {
            # Arrange
            
            $notionURL = $null
    
            # Act
            $result = Connect-Notion -BearerToken $BearerToken -notionURL $notionURL
    
            # Assert
            $result | Should -Be $null
        }
    }
    
    Context "When providing an empty URL" {
        It "Should fail to connect to the Notion API" {
            # Arrange
            
            $notionURL = ""
    
            # Act
            $result = Connect-Notion -BearerToken $BearerToken -notionURL $notionURL
    
            # Assert
            $result | Should -Be $null
        }
    }
}
