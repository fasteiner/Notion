Describe "Notion Heading Block Tests" {
    BeforeDiscovery {
        $script:projectPath = "$($PSScriptRoot)/../../../.." | Convert-Path

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

    Context "notion_heading_block" {
        It "should create an instance of notion_heading_block" {
            $instance = [notion_heading_block]::new("heading_1")
            $instance | Should -BeOfType [notion_heading_block]
            $instance.type | Should -Be "heading_1"
            $instance.getType().BaseType.Name | Should -Be "notion_block"
        }

        It "should create heading blocks using Create method" {
            $block1 = [notion_heading_block]::Create(1, "Heading One", "blue", $false)
            $block1.type | Should -Be "heading_1"
            $block1.heading_1.rich_text[0].plain_text | Should -Be "Heading One"
            $block1.heading_1.color.ToString() | Should -Be "blue"
            $block1.heading_1.is_toggleable | Should -BeFalse

            $block2 = [notion_heading_block]::Create(2, "Heading Two", "green", $true)
            $block2.type | Should -Be "heading_2"
            $block2.heading_2.is_toggleable | Should -BeTrue

            $block3 = [notion_heading_block]::Create(3, "Heading Three", "red", $false)
            $block3.type | Should -Be "heading_3"
            $block3.heading_3.color.ToString() | Should -Be "red"
        }

        It "should throw on invalid heading level" {
            
            $error.Clear()
            $ErrorActionPreference = "SilentlyContinue"
            $null = [notion_heading_block]::Create(4, "Invalid", "gray", $false) 
            $error[0].Exception.Message | Should -Match "Invalid heading level"

        }

        It "should convert heading_1 from object" {
            $mock = [PSCustomObject]@{
                type      = "heading_1"
                heading_1 = [PSCustomObject]@{
                    rich_text     = @([PSCustomObject]@{
                            type       = "text"
                            text       = @{ content = "Converted H1" }
                            plain_text = "Converted H1"
                        })
                    color         = "gray"
                    is_toggleable = $true
                }
            }
            $block = [notion_heading_block]::ConvertFromObject($mock)
            $block.type | Should -Be "heading_1"
            $block.heading_1.rich_text[0].plain_text | Should -Be "Converted H1"
            $block.heading_1.color.ToString() | Should -Be "gray"
            $block.heading_1.is_toggleable | Should -BeTrue
        }

        It "should convert heading_2 from object" {
            $mock = [PSCustomObject]@{
                type      = "heading_2"
                heading_2 = [PSCustomObject]@{
                    rich_text     = @([PSCustomObject]@{
                            type       = "text"
                            text       = @{ content = "Converted H2" }
                            plain_text = "Converted H2"
                        })
                    color         = "default"
                    is_toggleable = $false
                }
            }
            $block = [notion_heading_block]::ConvertFromObject($mock)
            $block.type | Should -Be "heading_2"
            $block.heading_2.rich_text[0].plain_text | Should -Be "Converted H2"
            $block.heading_2.color.ToString() | Should -Be "default"
            $block.heading_2.is_toggleable | Should -BeFalse
        }
    }

    Context "notion_heading_1_block" {
        It "should create an instance of notion_heading_1_block" {
            $instance = [notion_heading_1_block]::new()
            $instance.type | Should -Be "heading_1"
            $instance | Should -BeOfType [notion_heading_1_block]
            $instance.getType().BaseType.Name | Should -Be "notion_heading_block"
            $instance.heading_1.gettype().Name | Should -Be "Heading_structure"
        }
    }

    Context "notion_heading_2_block" {
        It "should create an instance of notion_heading_2_block" {
            $instance = [notion_heading_2_block]::new()
            $instance.type | Should -Be "heading_2"
            $instance | Should -BeOfType [notion_heading_2_block]
            $instance.heading_2.gettype().Name | Should -Be "Heading_structure"
        }
    }

    Context "notion_heading_3_block" {
        It "should create an instance of notion_heading_3_block" {
            $instance = [notion_heading_3_block]::new()
            $instance.type | Should -Be "heading_3"
            $instance | Should -BeOfType [notion_heading_3_block]
            $instance.heading_3.gettype().Name | Should -Be "Heading_structure"
        }
    }
}
