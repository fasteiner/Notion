# FILE: 01_Rich_text_text.Tests.ps1
Import-Module Pester -DisableNameChecking

BeforeDiscovery {
    $script:projectPath = "$($PSScriptRoot)/../../../../.." | Convert-Path

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

Describe "rich_text_text class" {
    InModuleScope $moduleName {
        Context "rich_text_text_structure class" {
            It "Should create an empty rich_text_text_structure" {
                $result = [rich_text_text_structure]::new()
                
                $result | Should -Not -BeNullOrEmpty
                $result.content | Should -Be ""
                $result.link | Should -BeNullOrEmpty
            }

            It "Should create rich_text_text_structure with content" {
                $content = "Test content"
                $result = [rich_text_text_structure]::new($content)
                
                $result.content | Should -Be $content
                $result.link | Should -BeNullOrEmpty
            }

            It "Should create rich_text_text_structure with content and link" {
                $content = "Test content"
                $link = "https://example.com"
                $result = [rich_text_text_structure]::new($content, $link)
                
                $result.content | Should -Be $content
                $result.link | Should -Be $link
            }

            It "Should convert from string" {
                $content = "Test content"
                $result = [rich_text_text_structure]::ConvertFromObject($content)
                
                $result.content | Should -Be $content
                $result.link | Should -BeNullOrEmpty
            }

            It "Should convert from object" {
                $obj = @{
                    content = "Test content"
                    link    = "https://example.com"
                }
                $result = [rich_text_text_structure]::ConvertFromObject($obj)
                
                $result.content | Should -Be $obj.content
                $result.link | Should -Be $obj.link
            }
        }

        Context "rich_text_text class" {
            It "Should create an empty rich_text_text" {
                $result = [rich_text_text]::new("")
                
                $result | Should -Not -BeNullOrEmpty
                $result.type | Should -Be "text"
                $result.text | Should -Not -BeNullOrEmpty
                $result.text.content | Should -Be ""
                $result.plain_text | Should -Be ""
            }

            It "Should create rich_text_text with string content" {
                $content = "Test content"
                $result = [rich_text_text]::new($content)
                
                $result.type | Should -Be "text"
                $result.text.content | Should -Be $content
                $result.plain_text | Should -Be $content
            }

            It "Should create rich_text_text with numeric content" {
                $content = 123
                $result = [rich_text_text]::new($content)
                
                $result.type | Should -Be "text"
                $result.text.content | Should -Be $content.ToString()
                $result.plain_text | Should -Be $content.ToString()
            }

            It "Should create rich_text_text with datetime content" {
                $content = [DateTime]::Now
                $result = [rich_text_text]::new($content)
                
                $result.type | Should -Be "text"
                $result.text.content | Should -Be $content.ToString()
                $result.plain_text | Should -Be $content.ToString()
            }

            It "Should create rich_text_text with content and annotations" {
                $content = "Test content"
                $annotations = @{
                    bold  = $true
                    color = "blue"
                }
                $result = [rich_text_text]::new($content, $annotations)
                
                $result.type | Should -Be "text"
                $result.text.content | Should -Be $content
                $result.plain_text | Should -Be $content
                $result.annotations.bold | Should -BeTrue
                $result.annotations.color | Should -Be "blue"
            }

            It "Should create rich_text_text with content, annotations, and href" {
                $content = "Test content"
                $annotations = @{
                    bold  = $true
                    color = "blue"
                }
                $href = "https://example.com"
                $result = [rich_text_text]::new($content, $annotations, $href)
                
                $result.type | Should -Be "text"
                $result.text.content | Should -Be $content
                $result.plain_text | Should -Be $content
                $result.annotations.bold | Should -BeTrue
                $result.annotations.color | Should -Be "blue"
                $result.href | Should -Be $href
            }

            It "Should convert from string" {
                $content = "Test content"
                $result = [rich_text_text]::ConvertFromObject($content)
                
                $result.type | Should -Be "text"
                $result.text.content | Should -Be $content
                $result.plain_text | Should -Be $content
            }

            It "Should convert from object" {
                $obj = @{
                    text = @{
                        content = "Test content"
                        link    = "https://example.com"
                    }
                }
                $result = [rich_text_text]::ConvertFromObject($obj)
                
                $result.type | Should -Be "text"
                $result.text.content | Should -Be $obj.text.content
                $result.plain_text | Should -Be $obj.text.content
            }
        }
    }
}
