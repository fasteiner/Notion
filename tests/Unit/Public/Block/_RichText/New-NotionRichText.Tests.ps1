# FILE: _RichText/New-NotionRichText.Tests.ps1
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

Describe "New-NotionRichText" {
    InModuleScope $moduleName {
        BeforeAll {
            Mock -CommandName New-NotionRichTextText -MockWith { 
                return "Mocked-RichTextText" 
            }
            Mock -CommandName New-NotionRichTextEquation -MockWith { 
                return "Mocked-RichTextEquation" 
            }
        }
        
        Context "Parameter validation" {
            It "Should have correct parameter sets" {
                (Get-Command New-NotionRichText).ParameterSets.Name | Should -Contain 'Text'
                (Get-Command New-NotionRichText).ParameterSets.Name | Should -Contain 'Equation'
                (Get-Command New-NotionRichText).ParameterSets.Name | Should -Contain 'ConvertFromMarkdown'
            }
        }
        
        Context "Text parameter set" {
            It "Should call New-NotionRichTextText with passed parameters" {
                $result = New-NotionRichText -Text "Hello" -Annotations @{bold = $true } -Link "https://example.com"
                
                Should -Invoke New-NotionRichTextText -Times 1 -Exactly -ParameterFilter { 
                    $Text -eq "Hello" -and 
                    $Annotations.bold -eq $true -and 
                    $Link -eq "https://example.com" 
                }
                $result | Should -Be "Mocked-RichTextText"
            }
        }
        
        Context "Equation parameter set" {
            It "Should call New-NotionRichTextEquation with passed parameters" {
                $result = New-NotionRichText -Expression "E=mc^2"
                
                Should -Invoke New-NotionRichTextEquation -Times 1 -Exactly
                $result | Should -Be "Mocked-RichTextEquation"
            }
        }
        
        Context "ConvertFromMarkdown parameter set" {
            It "Should throw when trying to convert markdown text" {
                { New-NotionRichText -MarkdownText "**Bold**" } | Should -Throw -ExpectedMessage "Markdown conversion is not yet implemented."
            }
        }
    }
}
