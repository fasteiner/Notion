function Update-NotionPageProperty
#https://developers.notion.com/reference/patch-page
{
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact = 'Medium')]
    [OutputType([notion_page])]
    param(
        [Parameter(Mandatory = $true, HelpMessage = "The ID of the page to remove")]
        [Alias("Id")]
        [string]$PageId,
        [Parameter(HelpMessage = "The title(-object) of the database")]
        [object[]] $title,
        [Parameter(HelpMessage = "The properties of the page")]
        [hashtable] $properties = @{},
        [Parameter(HelpMessage = "Set to true to delete the page. Set to false to restore the page.")]
        [bool]$in_trash = $false,
        [Parameter(HelpMessage = "Set to true to archive the page. Set to false to unarchive the page.")]
        [bool]$archived,
        [Parameter(HelpMessage = "A page icon for the page. Supported types are external file object or emoji object")]
        [notion_icon]$icon,
        [Parameter(HelpMessage = "A cover image for the page. Only external file objects are supported.")]
        [notion_file]$cover
    )

    $title = $title.foreach({
            if ($_ -is [rich_text])
            {
                $_
            }
            else
            {
                if ($_ -is [string])
                {
                    [rich_text_text]::new($_)
                }
                else
                {
                    [rich_text]::ConvertFromObject($_)
                }
            }
        })
        
    $body = @{
    }
    if ($title)
    {
        $body.title = @($title | Remove-NullValuesFromObject)
    }
    if($in_trash)
    {
        $body.archived = $in_trash
    }
    if($archived)
    {
        $body.archived = $archived
    }
    if($archived -and $in_trash)
    {
        Write-Error "You can't archive and delete a page at the same time" -Category InvalidOperation -RecommendedAction "Check the parameters"
        return $null
    }
    if ($icon)
    {
        if ($icon -isnot [notion_icon])
        {
            $icon = [notion_icon]::ConvertToObject($icon)
        }
        $body.Add("icon", [notion_icon]::ConvertFromObject($icon))
    }

    if ($cover)
    {
        if ($cover -isnot [notion_file])
        {
            $cover = [notion_file]::ConvertToObject($cover)
        }
        $body.Add("cover", [notion_file]::ConvertFromObject($cover))
    }
    
    if ($properties)
    {
        # here null values are not removed, because they are needed to remove properties
        $body.properties = $properties
    }

    if ($PSCmdlet.ShouldProcess("$PageId"))
    {
        $response = Invoke-NotionApiCall -method PATCH -uri "/pages/$PageId" -body $body
        return [notion_page]::ConvertFromObject($response)
    }
    else{
        Write-Debug "Operation cancelled by user"
        return $null
    }


}
