# Commands by verb (Add, Get, New,Remove, )
## New- commands

``` PowerShell
New-NotionBlock
New-NotionBlock -Type

New-NotionPage                                # TODO: destination teamspaces or private???

New-NotionDatabase

```

## Add- commands

``` PowerShell
Add-NotionBlock -PageId                       # Adds a block to the page
Add-NotionPage -PageId|-Database (alias)      # Adds a page to the page (child_page) or database ("database row")
Add-NotionDatabase -PageId                    # Adda a block of type child_database (= database) to a page
Add-NotionPageProperties -PageId              # Adds the given property to the page

Add-NotionDatabase -PageId                    # Adds an Block:child_database to the page, including an database object
```

## Remove- commands

``` PowerShell
Remove-NotionPage -PageId                     # Moves the page to trash
Remove-NotionPageProperty -PageId -PropertyId # Removes the specified property from the page
Remove-NotionPageProperty -PageId -All        # Removes all properties from the page

Remove-NotionBlock -BlockId                   # Removes the block and all sub-blocks

Remove-NotionDatabase                         # Removes the given database (set in_trash = true)
```

## Get- commands

``` PowerShell
Get-NotionDatabaseContent                     # returns the content of a database as array of objects (plain/class)
Set-/Update-NotionDatabaseContent
Import-NotionDatabaseContent                  # imports an array of objects into the given database
```

## Search- commands
``` PowerShell
Search-Notion [-Page|-Database] -Query        # Searches pages or databases for the query string
```

### Classes

``` PowerShell
[notion_block]::new()
```

# Commands by type (Object= Block, Page, PageProperties, Database, DatabaseProperties)
