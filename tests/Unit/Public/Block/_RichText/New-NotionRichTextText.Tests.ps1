# FILE: _RichText/New-NotionRichTextText.Tests.ps1
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

Describe "New-NotionRichTextText" {
    InModuleScope $moduleName {
        Context "Parameter validation" {
            It "Should have correct output type" {
                (Get-Command New-NotionRichTextText).OutputType.Type.Name | Should -Be "rich_text"
            }
            
            It "Should accept Text parameter" {
                (Get-Command New-NotionRichTextText).Parameters["Text"] | Should -Not -BeNullOrEmpty
            }
            
            It "Should accept Annotations parameter" {
                (Get-Command New-NotionRichTextText).Parameters["Annotations"] | Should -Not -BeNullOrEmpty
            }
            
            It "Should accept Link parameter" {
                (Get-Command New-NotionRichTextText).Parameters["Link"] | Should -Not -BeNullOrEmpty
            }
        }
        
        Context "Function behavior" {
            It "Should create a rich text object with text only" {
                $result = New-NotionRichTextText -Text "Hello World"
                
                $result | Should -BeOfType "rich_text"
                $result.type | Should -Be "text"
                $result.text.content | Should -Be "Hello World"
                $result.text.link | Should -BeNullOrEmpty
            }
            
            It "Should create a rich text object with text and annotations" {
                $annotations = @{bold = $true; color = "red" }
                $result = New-NotionRichTextText -Text "Hello World" -Annotations $annotations
                
                $result | Should -BeOfType "rich_text"
                $result.type | Should -Be "text"
                $result.text.content | Should -Be "Hello World"
                $result.annotations.bold | Should -Be $true
                $result.annotations.color | Should -BeOfType [notion_color]
                $result.annotations.color | Should -Be "red"
            }
            
            It "Should create a rich text object with text and link" {
                $result = New-NotionRichTextText -Text "Hello World" -Link "https://example.com"
                
                $result | Should -BeOfType "rich_text"
                $result.type | Should -Be "text"
                $result.text.content | Should -Be "Hello World"
                $result.text.link | Should -Be "https://example.com"
            }
            
            It "Should create a rich text object with all parameters" {
                $annotations = @{bold = $true; color = "red" }
                $result = New-NotionRichTextText -Text "Hello World" -Annotations $annotations -Link "https://example.com"
                
                $result | Should -BeOfType "rich_text"
                $result.type | Should -Be "text"
                $result.text.content | Should -Be "Hello World"
                $result.annotations.bold | Should -Be $true
                $result.annotations.color | Should -BeOfType [notion_color]
                $result.annotations.color | Should -Be "red"
                $result.text.link | Should -Be "https://example.com"
            }
            
            It "Should create a rich text object with empty text when not specified" {
                $result = New-NotionRichTextText
                
                $result | Should -BeOfType "rich_text"
                $result.type | Should -Be "text"
                $result.text.content | Should -Be ""
                $result.text.link | Should -BeNullOrEmpty
            }
        }
    }
}
