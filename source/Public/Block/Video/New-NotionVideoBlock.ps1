function New-NotionVideoBlock {
    <#
    .SYNOPSIS
        Creates a new Notion Video block.

    .DESCRIPTION
        The New-NotionVideoBlock function creates a new instance of a Notion Video block. 
        Users can either provide an InputObject or specify the caption, name, and URL to create the block.

    .PARAMETER InputObject
        The file object to be used for creating the Video block. This should be an object that can be converted 
        into a notion_video_block using the ConvertFromObject method.

    .PARAMETER caption
        The caption for the Video block.

    .PARAMETER url
        The URL of the Video file.

    .OUTPUTS
        [notion_video_block]
        Returns an instance of the notion_video_block class.

    .EXAMPLE
        $videoBlock = New-NotionVideoBlock -InputObject $fileObject

        Creates a new Notion Video block using the specified file object.

    .EXAMPLE
        $videoBlock = New-NotionVideoBlock -caption "My Video" -url "https://example.com/example.mp4"

        Creates a new Notion Video block using the specified caption and URL.

    .NOTES
        This function requires the notion_video_block class to be defined in the project.
    #>
    [CmdletBinding(DefaultParameterSetName = "InputObjectSet")]
    [OutputType([notion_video_block])]
    param(
        [Parameter(Mandatory = $True, ParameterSetName = "InputObjectSet")]
        [Alias("File")]
        [object] $InputObject,

        [Parameter(Mandatory = $True, ParameterSetName = "CaptionSet")]
        [object] $caption,

        # Not supported at the moment
        # [Parameter(Mandatory = $True, ParameterSetName = "CaptionSet")]
        # [string] $name,

        [Parameter(Mandatory = $True, ParameterSetName = "CaptionSet")]
        [string] $url
    )

    if ($PSCmdlet.ParameterSetName -eq "InputObjectSet") {
        # Create a new instance of notion_video_block using the provided InputObject
        return [notion_video_block]::ConvertFromObject($InputObject)
    } elseif ($PSCmdlet.ParameterSetName -eq "CaptionSet") {
        # Create a new instance of notion_video_block using the caption, name, and URL
        return [notion_video_block]::new("external", $null ,$caption, $url, $null)
    }
    return $null
}
