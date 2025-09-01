function New-NotionPdfBlock {
    <#
    .SYNOPSIS
        Creates a new Notion PDF block.
    
    .DESCRIPTION
        The New-NotionPdfBlock function creates a new instance of a Notion PDF block. 
        Users can either provide an InputObject or specify the caption, name, and URL to create the block.
    
    .PARAMETER InputObject
        The file object to be used for creating the PDF block. This should be an object that can be converted 
        into a notion_PDF_block using the ConvertFromObject method.
    
    .PARAMETER caption
        The caption for the PDF block.
    
    .PARAMETER url
        The URL of the PDF file.
    
    .OUTPUTS
        [notion_PDF_block]
        Returns an instance of the notion_PDF_block class.
    
    .EXAMPLE
        $pdfBlock = New-NotionPdfBlock -InputObject $fileObject
    
        Creates a new Notion PDF block using the specified file object.
    
    .EXAMPLE
        $pdfBlock = New-NotionPdfBlock -caption "My PDF" -url "https://example.com/example.pdf"

        Creates a new Notion PDF block using the specified caption and URL.

    .NOTES
        This function requires the notion_PDF_block class to be defined in the project.
    #>
    [CmdletBinding(DefaultParameterSetName = "InputObjectSet")]
    [OutputType([notion_PDF_block])]
    param (
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
        # Create a new instance of notion_PDF_block using the provided InputObject
        return [notion_PDF_block]::ConvertFromObject($InputObject)
    } elseif ($PSCmdlet.ParameterSetName -eq "CaptionSet") {
        # Create a new instance of notion_PDF_block using the caption, name, and URL
        return [notion_PDF_block]::new($caption, $url<#, $name#>)
    }
    return $null
}
