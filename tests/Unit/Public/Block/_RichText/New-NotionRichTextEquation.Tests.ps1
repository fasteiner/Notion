# FILE: _RichText/New-NotionRichTextEquation.Tests.ps1
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

Describe "New-NotionRichTextEquation" {
    InModuleScope $moduleName {
        Context "Parameter validation" {
            It "Should have mandatory Expression parameter" {
                $param = (Get-Command New-NotionRichTextEquation).Parameters["Expression"]
                $param | Should -Not -BeNullOrEmpty
                $param.Attributes.Where{ $_ -is [System.Management.Automation.ParameterAttribute] }.Mandatory | Should -BeTrue
            }
            
            It "Should accept Annotations parameter" {
                (Get-Command New-NotionRichTextEquation).Parameters["Annotations"] | Should -Not -BeNullOrEmpty
            }
            
            It "Should have correct output type" {
                (Get-Command New-NotionRichTextEquation).OutputType.Type.Name | Should -Be "rich_text_equation"
            }
        }
        
        Context "Function behavior" {
            It "Should create a rich text equation with expression" {
                # Fix the variable name in the function
                Mock -CommandName ConvertTo-NotionObject -MockWith {
                    return [rich_text_equation]::new("E=mc^2")
                }
                
                $result = New-NotionRichTextEquation -Expression "E=mc^2"
                
                $result | Should -BeOfType "rich_text_equation"
                $result.type | Should -Be "equation"
                $result.equation.expression | Should -Be "E=mc^2"
            }
            
            It "Should create a rich text equation with expression and annotations" {
                $annotations = @{bold = $true; color = "red" }
                
                $result = New-NotionRichTextEquation -Expression "E=mc^2" -Annotations $annotations
                
                $result | Should -BeOfType "rich_text_equation"
                $result.type | Should -Be "equation"
                $result.equation.expression | Should -Be "E=mc^2"
                $result.annotations.bold | Should -Be $true
                $result.annotations.color | Should -BeOfType [notion_color]
                $result.annotations.color | Should -Be "red"
            }
        }
    }
}
