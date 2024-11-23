# Commands by verb (Add, Get, New,Remove, )
## New- commands

``` PowerShell
New-TSNotionBlock
New-TSNotionBlock -Type

New-TSNotionPage                                # TODO: destination teamspaces or private???

New-TSNotionDatabase

```

## Add- commands

``` PowerShell
Add-TSNotionBlock -PageId                       # Adds a block to the page
Add-TSNotionPage -PageId|-Database (alias)      # Adds a page to the page (child_page) or database ("database row")
Add-TSNotionDatabase -PageId                    # Adda a block of type child_database (= database) to a page
Add-TSNotionPageProperties -PageId              # Adds the given property to the page

Add-TSNotionDatabase -PageId                    # Adds an Block:child_database to the page, including an database object
```

## Remove- commands

``` PowerShell
Remove-TSNotionPage -PageId                     # Moves the page to trash
Remove-TSNotionPageProperty -PageId -PropertyId # Removes the specified property from the page
Remove-TSNotionPageProperty -PageId -All        # Removes all properties from the page

Remove-TSNotionBlock -BlockId                   # Removes the block and all sub-blocks

Remove-TSNotionDatabase                         # Removes the given database (set in_trash = true)
```

## Get- commands

``` PowerShell
Get-TSNotionDatabaseContent                     # returns the content of a database as array of objects (plain/class)
Set-/Update-TSNotionDatabaseContent
Import-TSNotionDatabaseContent                  # imports an array of objects into the given database
```

## Search- commands
``` PowerShell
Search-TSNotion [-Page|-Database] -Query        # Searches pages or databases for the query string
```

### Classes

``` PowerShell
[notion_block]::new()
```

# Commands by type (Object= Block, Page, PageProperties, Database, DatabaseProperties)
