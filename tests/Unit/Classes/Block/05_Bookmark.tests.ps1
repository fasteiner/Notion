# Import the module containing the Get-NotionUser function
Import-Module Pester

BeforeDiscovery {
    $projectPath = "$($PSScriptRoot)/../../../.." | Convert-Path

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

    $mut = Import-Module -Name "$projectPath/output/module/$ProjectName" -Force -ErrorAction Stop -PassThru

}
Describe "notion_bookmark_block Tests" {
    Context "Constructor Tests" {
        It "Should create a notion_bookmark_block" {
            $url = "http://example.com"
            $block = [notion_bookmark_block]::new($url)
            $block | Should -BeOfType "notion_bookmark_block"
            $block.type | Should -Be "bookmark"
            $block.type | Should -Be "bookmark"
            $block.bookmark.getType().Name | Should -Be "bookmark_structure"
            $block.bookmark.url | Should -Be $url
        }
    }
    
    Context "ConvertFromObject Tests" {
        It "Should convert from object correctly" {
            $mockObject = [PSCustomObject]@{
                bookmark = [PSCustomObject]@{
                    url     = "http://example.com"
                    caption = @([PSCustomObject]@{ plain_text = "Example"; type = "text" })
                }
            }
            $block = [notion_bookmark_block]::ConvertFromObject($mockObject)
            $block.bookmark.url | Should -Be $mockObject.bookmark.url
            $block.bookmark.caption[0].plain_text | Should -Be $mockObject.bookmark.caption[0].plain_text
            $block.type | Should -Be "bookmark"
            $block.bookmark.getType().Name | Should -Be "bookmark_structure"
        }
    }
}
