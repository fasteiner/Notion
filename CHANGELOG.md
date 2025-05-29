# Changelog for Notion

The format is based on and uses the types of changes according to [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]


### Added

- `.vscode/settings.json`: added `terminal.integrated.bracketedPasteMode` setting
- `build.yaml`: added `minibuild` task with steps for `Clean`, `Build_Module_ModuleBuilder`, and `Build_NestedModules_ModuleBuilder`
- `source/Classes/03_File/01_notion_file.ps1`:  
  - Added static `Create` method to instantiate child objects based on file type
- `source/Classes/Block/RichText/01_Rich_Text.ps1`:  
  - Added `ConvertFromObjects` method to convert arrays or single objects into `rich_text[]`
- `source/Classes/Block/04_Block.ps1`:  
  - Improved error messages for unsupported and unknown block types with GitHub issue link and quoted block type
- `source/Classes/Block/05_Bookmark.ps1`:  
  - Refactored constructors to support flexible input types and added `ConvertFromObject` method
- `source/Classes/Block/07_Bulleted_List_Item.ps1`:  
  - Refactored constructors to use `ConvertFromObjects` and support flexible input
- `source/Classes/Block/08_Callout.ps1`:  
  - Refactored constructors and added `ConvertFromObject` for emoji and rich text
- `source/Classes/Block/09_Child_Database.ps1`:  
  - Used `ConvertFromObject` for `child_database_structure`
- `source/Classes/Block/10_Child_Page.ps1`:  
  - Used `ConvertFromObject` for `child_page_structure`
- `source/Classes/Block/11_Code.ps1`:  
  - Refactored constructors to use `ConvertFromObjects` and support caption
- `source/Classes/Block/15_Embed.ps1`:  
  - Added support for `caption` and `ConvertFromObject` improvements
- `source/Classes/Block/16_Equation.ps1`:  
  - Renamed constructors to match class name
- `source/Classes/Block/21_Image.ps1`:  
  - Added support for `caption` and improved `ConvertFromObject`
- `source/Classes/Block/31_To_do.ps1`:  
  - Refactored constructor to remove base call
- `source/Classes/Block/33_Video.ps1`:  
  - Refactored constructors to use `Create` method and support caption
- `source/Classes/Emoji/01_emoji.ps1`:  
  - Added `ConvertFromObject` method to handle strings and emoji objects
- `tests/Integration/Block/testpage.tests.ps1`:  
  - Improved test logic for unsupported block types with specific error message checks

### Changed

- `RequiredModules.psd1`: switched to Pester Version 6
- Refactored multiple constructors across block classes to support more flexible input types and use `ConvertFromObjects` for consistency

### Fixed

- `source/Enum/01_notion_color.ps1`: added `default_backround` as a color (missing in documentation but available in API)
- `source/Classes/Block/32_Toggle.ps1`: fixed class `notion_toggle_block`
- `source/Classes/Block/33_Video.ps1`: fixed constructors to use `Create` method and correct file instantiation
- `source/Classes/Block/05_Bookmark.ps1`:  
  - Fixed constructors  
  - `bookmark_structure`: fixed constructor with two parameters to fully support `rich_text`
- `source/Classes/Block/07_Bulleted_List_Item.ps1`:  
  - Fixed `rich_text` conversion in constructors
- `source/Classes/Block/08_Callout.ps1`:  
  - Fixed constructors and emoji handling
- `source/Classes/Emoji/01_emoji.ps1`:  
  - Fixed `ConvertFromObject` to handle strings and emoji objects


## [0.3.0] - 2025-05-18

### Fixed

- Fix Wiki Sidebar
- Fix Logo in ReadMe

## [0.2.0] - 2025-05-18

### Added

- Documentation to Classes: Comment, Emoji, File, General, Page, Parent, User
- Documentation to Classes: Block, Database, DatabaseProperties
- Documentation to Classes: add relation between classes, in dedicated docs folder
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
