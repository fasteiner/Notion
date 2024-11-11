# Import the module containing the Get-TSNotionUser function
Import-Module Pester

BeforeDiscovery {
    $projectPath = "$($PSScriptRoot)\..\..\.." | Convert-Path

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

    $mut = Get-Module -Name $global:moduleName -ListAvailable |
        Select-Object -First 1 |
            Import-Module -Force -ErrorAction Stop -PassThru
}

Describe "Get-TSNotionUser Tests" {
    BeforeAll {
        $global:expectedResponses = @(@{
            id = "e79a0b74-3aba-4149-9f74-0bb5791a6ee6"
            name = "Test User"
            email = "testuser@example.com"
            type = "person"
        },
        @{
            object = "user"
            id = "e79a0b74-abba-4149-9f84-0bb5792a6ee6"
            avatar_url = "https://example.com/avatar.jpg"
            name = "Test User"
            type = "bot"
        })
    }
    Context "When UserId is provided" {
        BeforeAll{
            Mock -ModuleName $global:moduleName Invoke-TSNotionApiCall {
                $userID = $uri.split("/")[-1]
                if($userId -eq "me"){
                    return $global:expectedResponses[1]
                }
                if(!$userID){
                    return $global:expectedResponses
                }
                return $global:expectedResponses.Where({$_.id -eq $userID})
            }
        }
        It "Should return user information for a valid user ID" {
            # Arrange
            $userId = "e79a0b74-3aba-4149-9f74-0bb5791a6ee6"
            $localResponse = [user]::ConvertFromObject($global:expectedResponses[0])

            # Act
            $result = Get-TSNotionUser -UserId $userId

            # Assert
            $result | Should -Be $localResponse
            $result | Should -BeOfType [user]
        }

        It "Should return user information for 'me'" {
            # Arrange
            $userId = "me"

            $localResponse = [user]::ConvertFromObject($global:expectedResponses[1])

            # Act
            $result = Get-TSNotionUser -UserId $userId

            # Assert
            $result | Should -Be $localResponse
            $result | Should -BeOfType [user]
        }

        It "Should return all users when UserId is null" {
            # Arrange

            $localResponses = $global:expectedResponses.ForEach({ [user]::ConvertFromObject($_) })

            # Act
            $result = Get-TSNotionUser

            # Assert
            for($i = 0; $i -lt $result.Count; $i++){
                $result[$i] | Should -Be $localResponses[$i]
            }
            $result | Should -BeOfType [user]
            $result.Count | Should -Be $expectedResponses.Count
        }
    }


    Context "When an invalid UserId is provided" {
        It "Should return an error" {
            # Arrange
            $userId = "invalid-user-id"

            # Act
            { Get-TSNotionUser -UserId $userId } | Should -Throw
        }
    }
}
