function New-NotionBlock
{
    [CmdletBinding(DefaultParameterSetName = 'paragraph')]
    param (
        [Parameter(ParameterSetName = 'bookmark', Mandatory = $true)]
        [switch]$bookmark,
        [Parameter(ParameterSetName = 'bookmark', Mandatory = $true)]
        [string]$Url,        
        [Parameter(ParameterSetName = 'bookmark')]
        [object]$Caption,

        [Parameter(ParameterSetName = 'breadcrumb', Mandatory = $true)]
        [switch]$breadcrumb,

        [Parameter(ParameterSetName = 'bulleted_list_item', Mandatory = $true)]
        [switch]$bulleted_list_item,
        [Parameter(ParameterSetName = 'bulleted_list_item', Mandatory = $true)]
        $Text,
        [Parameter(ParameterSetName = 'bulleted_list_item')]
        [notion_color]$Color,

        [Parameter(ParameterSetName = 'callout', Mandatory = $true)]
        [switch]$callout,
        [Parameter(ParameterSetName = 'callout')]
        [switch]$Icon,

        [Parameter(ParameterSetName = 'child_database', Mandatory = $true)]
        [switch]$child_database,

        [Parameter(ParameterSetName = 'child_page', Mandatory = $true)]
        [switch]$child_page,

        [Parameter(ParameterSetName = 'code', Mandatory = $true)]
        [switch]$code,
        [Parameter(ParameterSetName = 'code')]
        [switch]$Language,

        [Parameter(ParameterSetName = 'column', Mandatory = $true)]
        [switch]$column,

        [Parameter(ParameterSetName = 'column_list', Mandatory = $true)]
        [switch]$column_list,

        [Parameter(ParameterSetName = 'divider', Mandatory = $true)]
        [switch]$divider,

        [Parameter(ParameterSetName = 'embed', Mandatory = $true)]
        [switch]$embed,

        [Parameter(ParameterSetName = 'equation', Mandatory = $true)]
        [switch]$equation,

        [Parameter(ParameterSetName = 'file', Mandatory = $true)]
        [switch]$file,

        [Parameter(ParameterSetName = 'heading_1', Mandatory = $true)]
        [switch]$heading_1,

        [Parameter(ParameterSetName = 'heading_2', Mandatory = $true)]
        [switch]$heading_2,

        [Parameter(ParameterSetName = 'heading_3', Mandatory = $true)]
        [switch]$heading_3,

        [Parameter(ParameterSetName = 'image', Mandatory = $true)]
        [switch]$image,

        [Parameter(ParameterSetName = 'link_preview', Mandatory = $true)]
        [switch]$link_preview,

        [Parameter(ParameterSetName = 'link_to_page', Mandatory = $true)]
        [switch]$link_to_page,

        [Parameter(ParameterSetName = 'numbered_list_item', Mandatory = $true)]
        [switch]$numbered_list_item,

        [Parameter(ParameterSetName = 'paragraph', Mandatory = $true)]
        [switch]$paragraph,

        [Parameter(ParameterSetName = 'pdf', Mandatory = $true)]
        [switch]$pdf,

        [Parameter(ParameterSetName = 'quote', Mandatory = $true)]
        [switch]$quote,

        [Parameter(ParameterSetName = 'synced_block', Mandatory = $true)]
        [switch]$synced_block,

        [Parameter(ParameterSetName = 'table', Mandatory = $true)]
        [switch]$table,

        [Parameter(ParameterSetName = 'table_of_contents', Mandatory = $true)]
        [switch]$table_of_contents,

        [Parameter(ParameterSetName = 'table_row', Mandatory = $true)]
        [switch]$table_row,

        [Parameter(ParameterSetName = 'template', Mandatory = $true)]
        [switch]$template,

        [Parameter(ParameterSetName = 'to_do', Mandatory = $true)]
        [switch]$to_do,
        [Parameter(ParameterSetName = 'to_do')]
        [switch]$Checked = $false,

        [Parameter(ParameterSetName = 'toggle', Mandatory = $true)]
        [switch]$toggle,

        [Parameter(ParameterSetName = 'unsupported', Mandatory = $true)]
        [switch]$unsupported,

        [Parameter(ParameterSetName = 'video', Mandatory = $true)]
        [switch]$video
    )

    # Beispielhafte Ausgabe
    Write-Output "BlockType: $($PSCmdlet.ParameterSetName)"
    Write-Output "Parameters: $($PSBoundParameters | Out-String)"
    Write-Output "----"

    switch ($PSCmdlet.ParameterSetName)
    {
        "bookmark"
        { 
            # Variant A
            $block = ($caption) ? [notion_bookmark_block]::new($Url, $Caption) : [notion_bookmark_block]::new($Url)
            # Variant B
            Write-Host "[notion_bookmark_block]::new($Url)"
            Write-Host "[notion_bookmark_block]::new($Url, $Caption)"

        }
        "breadcrumb"
        {
            $block = [notion_breadcrumb_block]::new() 
        }
        "bulleted_list_item"
        {
            $block = [notion_bulleted_list_item_block]::new() 
        }
        "callout"
        {
            $block = [notion_callout_block]::new() 
        }
        "child_database"
        {
            $block = [notion_child_database_block]::new() 
        }
        "child_page"
        {
            $block = [notion_child_page_block]::new() 
        }
        "code"
        {
            $block = [notion_code_block]::new() 
        }
        "column"
        {
            $block = [notion_column_block]::new() 
        }
        "column_list"
        {
            $block = [notion_column_list_block]::new() 
        }
        "divider"
        {
            $block = [notion_divider_block]::new() 
        }
        "embed"
        {
            $block = [notion_embed_block]::new() 
        }
        "equation"
        {
            $block = [notion_equation_block]::new() 
        }
        "file"
        {
            $block = [notion_file_block]::new() 
        }
        "heading_1"
        {
            $block = [notion_heading_1_block]::new() 
        }
        "heading_2"
        {
            $block = [notion_heading_2_block]::new() 
        }
        "heading_3"
        {
            $block = [notion_heading_3_block]::new() 
        }
        "image"
        {
            $block = [notion_image_block]::new() 
        }
        "link_preview"
        {
            $block = [notion_link_preview_block]::new() 
        }
        "link_to_page"
        {
            $block = [notion_link_to_page_block]::new() 
        }
        "numbered_list_item"
        {
            $block = [notion_numbered_list_item_block]::new() 
        }
        "paragraph"
        {
            $block = [notion_paragraph_block]::new() 
        }
        "pdf"
        {
            $block = [notion_pdf_block]::new() 
        }
        "quote"
        {
            $block = [notion_quote_block]::new() 
        }
        "synced_block"
        {
            $block = [notion_synced_block]::new() 
        }
        "table"
        {
            $block = [notion_table_block]::new() 
        }
        "table_of_contents"
        {
            $block = [notion_table_of_contents_block]::new() 
        }
        "table_row"
        {
            $block = [notion_table_row_block]::new() 
        }
        "template"
        {
            $block = [notion_template_block]::new() 
        }
        "to_do"
        {
            $block = [notion_to_do_block]::new() 
        }
        "toggle"
        {
            $block = [notion_toggle_block]::new() 
        }
        "unsupported"
        {
            $block = [notion_unsupported_block]::new() 
        }
        "video"
        {
            $block = [notion_video_block]::new() 
        }
        default
        {
            throw "Unbekannter Blocktyp: $($PSCmdlet.ParameterSetName)" 
        }
    }
    return $block
}
