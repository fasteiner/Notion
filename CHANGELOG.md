# Changelog for Notion

The format is based on and uses the types of changes according to [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]



### Added

- Documentation to all PSCmdlets
- prepared automatic Wiki Generation
- Add-NotionPageToDatabase, Move-NotionPageToArchive: prepared
- Get-NotionPageProperty: prepared and partly tested
- Update-NotionPageProperty: prepared
- Add-NotionDatabaseProperty, Remove-NotionDatabaseProperty, Move-NotionPageToArchive: prepared 
- Add-NotionBlockToPage: prepared
- Get-NotionPageChildren: implemented
- Remove-NotionBlock: function to remove / trash a block
- Update-NotionBlock: function to update a block
- New-NotionTable: function to create a new table
- New-NotionTableRow: function to create a new table row

### Changed

- Module Manifest: Added Metadata
- Filenames: changed to match the cmdlet names
- ConvertTo-NotionObject: include property_item
- Disconnect-Notion: improve Confirm message
- Restore-NotionPage, Restore-NotionDatabase: add archived = $false, to ensure restore is possible from both trash and archive
- For changes in existing functionality.
- Remove-NotionPage: specify output type, fix code
- Get-NotionBlockChildren: refactored

### Deprecated

- For soon-to-be removed features.

### Removed

- page, Get-NotionPage: remove children
- TableCell: was only a wrongly implemented wrapper for rich_text

### Fixed

- Add-NotionHeaderToBlock: fix parameter types
- New-NotionHeader: switch to factory method of notion_heading_block
- block: fix ConvertFrom-Object
- Column List: fix ConvertFrom-Object
- Numbered List item: Fix constructors and color conversion to enum
- paragraph: added color in ConvertFrom-Object
- to_do: Fixed ConvertFrom-Object, added default constructor
- Heading: Adjusted implementation to match API Schema
- Remove-NullValuesFromObject: fix DateTime objects and remove empty arrays, include handling for nested arrays
- notion_table_block: implemented according to API Schema
- notion_table_row_block: implemented according to API Schema
- rich_text_text: handle primitive types correctly

### Security

- API Variables: switch from global to script scope
