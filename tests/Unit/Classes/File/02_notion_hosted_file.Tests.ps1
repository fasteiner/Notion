

# Import the module containing the notion_file class
# Import the module containing the Get-NotionUser function
Import-Module Pester -DisableNameChecking

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

Describe "notion_hosted_file" {
    It "should create an instance with default constructor" {
        $instance = [notion_hosted_file]::new()
        $instance | Should -BeOfType [notion_hosted_file]
        $instance.file | Should -BeNullOrEmpty
    }

    It "should create an instance with parameters" {
        $name = "Test File"
        $caption = "Test Caption"
        $url = "https://example.com/file"
        $expiry_time = "2023-12-31T23:59:59.000Z"
        $instance = [notion_hosted_file]::new($name, $caption, $url, $expiry_time)
        $instance.name | Should -Be $name
        $instance.caption[0].plain_text | Should -Be $caption
        $instance.file.url | Should -Be $url
        $instance.file.expiry_time | Should -Be (Get-Date $expiry_time).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ss.fffZ")
    }

    It "should create an instance with rich_text caption" {
        $name = "Test File"
        $caption = @([rich_text_text]::new("Test Caption"))
        $url = "https://example.com/file"
        $expiry_time = "2023-12-31T23:59:59.000Z"
        $instance = [notion_hosted_file]::new($name, $caption, $url, $expiry_time)
        $instance.name | Should -Be $name
        $instance.caption[0].plain_text | Should -Be $caption.plain_text
        $instance.file.url | Should -Be $url
        $instance.file.expiry_time | Should -Be (Get-Date $expiry_time).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ss.fffZ")
    }

    It "should convert from object" {
        $obj = [pscustomobject]@{
            type = "file"
            name = "Test File"
            caption = @([pscustomobject]@{ 
                type = "text"
                text = @{
                    content = "Test Caption"
                    link = $null
                } 
             })
            file = [pscustomobject]@{
                url = "https://example.com/file"
                expiry_time = [datetime]::UtcNow
            }
        }
        $instance = [notion_hosted_file]::ConvertFromObject($obj)
        $instance | Should -BeOfType [notion_hosted_file]
        $instance.type | Should -Be $obj.type
        $instance.name | Should -Be $obj.name
        $instance.caption[0].plain_text | Should -Be $obj.caption[0].text.content
        $instance.file.url | Should -Be $obj.file.url
        $instance.file.expiry_time | Should -Be (Get-Date $obj.file.expiry_time).ToString("yyyy-MM-ddTHH:mm:ss.fffZ")
    }
}
