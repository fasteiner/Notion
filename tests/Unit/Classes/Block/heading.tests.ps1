Describe "Notion Heading Block Tests" {
    BeforeDiscovery {
        $script:projectPath = "$($PSScriptRoot)/../../../.." | Convert-Path
    
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
    

    Context "notion_heading_block" {
        It "should create an instance of notion_heading_block" {
            $instance = [notion_heading_block]::new("heading_1")
            $instance | Should -BeOfType [notion_heading_block]
            $instance.type | Should -Be "heading_1"
            $instance.getType().BaseType.Name | Should -Be "notion_block"
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
