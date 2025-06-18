function New-NotionPage
{
    <#
    .SYNOPSIS
        Creates a new Notion page.

    .DESCRIPTION
        The New-NotionPage function creates a new Notion page with specified properties, children blocks, icon, and cover image.
        If no parent object is provided, the page will be created at the root (workspace) level.

    .PARAMETER parent_obj
        The parent object of the page. If empty, the page will be created at the root (workspace) level.

    .PARAMETER properties
        The properties of the page. This should be a hashtable.

    .PARAMETER children
        An array of blocks within this page.

    .PARAMETER icon
        The icon of the page.

    .PARAMETER cover
        The cover image of the page (see notion_file).

    .PARAMETER title
        The title of the page. This will overwrite the title property if it exists.

    .EXAMPLE
        New-NotionPage -parent_obj $parent -properties @{Property1="Value1"} -title "New Page Title"

        Creates a new Notion page with the specified parent object, properties, and title "New Page Title".

    .EXAMPLE
        $parent = New-NotionParent -Type "workspace"
        New-NotionPage -parent_obj $parent -properties @{Title="My New Page"; Status="Draft"} -children @([notion_paragraph_block]::new("This is a new page.")) -Icon (New-NotionEmoji -Emoji "📄") -Cover (New-NotionFile -Type "external" -Url "https://example.com/cover.jpg")

        Creates a new Notion page under the specified workspace parent with properties, children blocks, an icon, and a cover image.

    .NOTES
        This function requires the Invoke-NotionApiCall function to be defined.

    .LINK
        https://developers.notion.com/reference/post-page
    #>
    [CmdletBinding()]
    [OutputType([notion_page])]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "The parent object of the page")] #, if empty it will be created at the root (workspace) level")]
        [object] $parent_obj,
        [Parameter(HelpMessage = "The properties of the page")]
        [hashtable] $properties = @{},
        [Parameter(HelpMessage = "An array of blocks within this page")]
        $children = @(),
        [Parameter(HelpMessage = "The icon of the page(type notion_file or notion_emoji). e.g. 🍸")]
        $Icon,
        [Parameter(HelpMessage = "The cover image of the page (see notion_file) e.g. @{type = ""external""; url = ""https://www.notion.so/images/page-cover/webb4.jpg"" }")]
        $Cover,
        [Parameter(HelpMessage = "The title of the page. (Will overwrite the title-property if it exists)")]
        $Title
    )
    try
    {
        if (-not (Test-NotionApiSettings $MyInvocation.MyCommand.Name))
        {
            return
        }

        $body = @{}
    
        # if $parent_obj is not provided, add page to Workspace (not supported by Notion API at the moment)
        #$parent_obj ??= [notion_workspace_parent]::new()

        if ($parent_obj -isnot [notion_parent])
        {
            $parent_obj = [notion_parent]::ConvertFromObject($parent_obj)
        }
        $body.Add("parent", $parent_obj)

        if (($parent.Type -eq "page_id") -and ($properties -gt 0))
        {
            Write-Warning "the new page is a child of an existing page, title is the only valid property!"
            $properties = @{}
        }

        if (($properties.count -gt 0) -and ($properties -isnot [notion_pageproperties]))
        {
            $properties = [notion_pageproperties]::ConvertFromObject($properties)
        }

        if ($title -and (-not $properties.title))
        {
            # #BUG: [notion_title_page_property]::new($title) geht so nicht
            # $titleobj = [rich_text]::new([notion_rich_text_type]::text, [notion_annotation]::new())
            # $titleobj.plain_text = $title
            # $properties.Add("Title", $titleobj)
            $properties.Add("title", [notion_title_page_property]::new($title))
        }
        elseif ($title -and $properties.Title)
        {
            $properties.Title = [notion_title_page_property]::new($title)
        }
        $body.Add("properties", $properties)

        if ($children)
        {
            [array]$childrenList += $children.ForEach({
                    if ($_ -is [notion_block])
                    {
                        $_
                    }
                    else
                    {
                        [notion_block]::ConvertFromObject($_)
                    }
                })
            $body.Add("children", $childrenList)
        }
    
        if ($icon)
        {
            if ($icon -is [notion_file])
            {
                $icon = [notion_file]::ConvertFromObject($icon)
            }
            else
            {
                $icon = [notion_emoji]::ConvertFromObject($icon)
            }
            $body.Add("icon", $icon)
        }

        if ($cover)
        {
            if ($cover -isnot [notion_file])
            {
                $cover = [notion_file]::ConvertToObject($cover)
            }
            $body.Add("cover", [notion_file]::ConvertFromObject($cover))
        }
    }
    catch
    {
        Write-Host -ForegroundColor Green "TS"
        Write-Host -ForegroundColor Cyan $properties
        Write-Error $_.Exception.Message
        Write-Host -ForegroundColor Magenta ($body | conertto-json)
        Write-Host -ForegroundColor Green "--"
    }
    try
    {
        $body = $body | Remove-NullValuesFromObject
        Write-Debug "New-NotionPage: `n Body: `n$($body | ConvertTo-Json -Depth 10 -EnumsAsStrings)"
        $response = Invoke-NotionAPICall -Method POST -uri "/pages" -Body $body
        return [notion_page]::ConvertFromObject($response)
    }
    catch
    {
        Write-Error $_.Exception.Message
    }
}
