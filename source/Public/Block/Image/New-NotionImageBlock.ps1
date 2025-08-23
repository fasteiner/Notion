function New-NotionImageBlock {
[CmdletBinding()]
    [OutputType([notion_image_block])]
    param (
        [Parameter(Mandatory = $True)]
        [object] $File
    )

    # Create a new instance of notion_image_block using the provided parameter
    $imageBlock = [notion_image_block]::ConvertFromObject($File)

    return $imageBlock
}
