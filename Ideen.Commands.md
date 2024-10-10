# TSNotion Commands

## New- commands

``` PowerShell
New-TSNotionBlock
New-TSNotionBlock -Type

New-TSNotionPage                                # TODO: destination teamspaces or private???
```

## Add- commands

``` PowerShell
Add-TSNotionBlock -PageId                       # Adds a block to the page
Add-TSNotionPage -PageId|-Database (alias)      # Adds a page to the page (childpage) or database ("database row")
Add-TSNotionDatabase -PageId                    # Adda a block of type ChildDatabase (= database) to a page
Add-TSNotionPageProperties -PageId              # Adds the given property to the page
```

## Remove- commands

``` PowerShell
Remove-TSNotionPage -PageId                     # Moves the page to trash
Remove-TSNotionPageProperty -PageId -PropertyId # Removes the specified property from the page
Remove-TSNotionPageProperty -PageId -All        # Removes all properties from the page
Remove-TSNotionBlock -BlockId                   # Removes the block and all sub-blocks
```

## Get- commands

``` PowerShell
Get-TSNotionDatabaseContent                     # returns the content of a database as array of objects (plain/class)
Set-/Update-TSNotionDatabaseContent
Import-TSNotionDatabaseContent                  # imports an array of objects into the given database
```

### Classes

``` PowerShell
[block]::new()
```