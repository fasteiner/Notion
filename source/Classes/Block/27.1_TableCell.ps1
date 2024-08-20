class TableCell
{
    #eigentlich ist es ein rich text object
    [rich_text_type] $type = "text"
    $text = @{
        "content" = ""
        "link"    = $null
    }
    [annotation] $annotations = [annotation]::new()

    # empty tablecell
    TableCell()
    {
        $this.text = @{
            "content" = ""
            "link"    = $null
        }
        $this.annotations = [annotation]::new()
    }

    # tablecell with content
    # [tablecell]::new("Hallo")
    TableCell ([string] $content)
    {
        $this.text = @{
            "content" = $content
            "link"    = $null
        }
        $this.annotations = [annotation]::new()
    }

    # tablecell with content and annotations
    # [tablecell]::new("Hallo", [annotation]::new("bold"))
    TableCell ([string] $content, [annotation] $annotations)
    {
        $this.text = @{
            "content" = $content
            "link"    = $null
        }
        $this.annotations = $annotations
    }
    [string] ToString()
    {
        return $this.text.content
    }
}
# class TableCells : System.Collections.IEnumerable{
#     #internal collection
#     hidden [System.Collections.ArrayList]$items = @()

#     TableCells() {
#         $this.items = [System.Collections.ArrayList]::new()
#         $defaultDisplayPropertySet = New-Object System.Management.Automation.PSPropertySet('DefaultDisplayPropertySet', [string[]]@('items'))
#         $standardMembers = [System.Management.Automation.PSMemberInfo[]]@($defaultDisplayPropertySet)
#         $this.psobject.TypeNames.Insert(0, 'TableCells')
#         $this.psobject.Members.Add((New-Object System.Management.Automation.PSMemberSet('PSStandardMembers', $standardMembers)))
#     }

#     # Overloaded AddCell methods
#     AddCell() {
#         $this.items.Add([TableCell]::new())
#     }

#     AddCell([string]$cellcontent) {
#         $this.items.Add([TableCell]::new($cellcontent))
#     }

#     AddCell($cellcontent, [annotation]$annotations) {
#         $this.items.Add([TableCell]::new($cellcontent, $annotations))
#     }

#     # GetEnumerator for IEnumerable implementation
#     [System.Collections.IEnumerator] GetEnumerator() {
#         return $this.items.GetEnumerator()
#     }

# }

<#
    NewTable() {
        $this.id = [guid]::NewGuid().ToString()
        $this.type = "table"
        $this.table = [Table]::new()
    }
    #>
