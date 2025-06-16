# Changelog for Notion

The format is based on and uses the types of changes according to [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- **`.devcontainer/devcontainer.json`**
  - Added VS Code extensions: `github.vscode-github-actions` and `shd101wyy.markdown-preview-enhanced` for enhanced GitHub workflow support and markdown preview.

- **`.vscode/extensions.json`**
  - Added the same extensions as above to the recommended list.

- **`.github/templates/README.template.md`**
  - Introduced a new README template that dynamically includes `README.md`, `CONTRIBUTING.md`, the Wiki homepage, and `CHANGELOG.md`.

- **`.github/workflows/generate-project-page.yml`**
  - Created a new GitHub Actions workflow to generate and deploy a project page from a feature branch.
  - Steps include:
    - Checkout and metadata actions.
    - Rendering dynamic README content.
    - Preparing and generating a Jekyll-based site.
    - Publishing to GitHub Pages using `peaceiris/actions-gh-pages`.

- **`GemFile`**
  - Added Gem dependencies for GitHub Pages site:
    - `jekyll`, `minima`, `csv`, `logger`, and `base64`.

- **`jekyll_config.yml`**
  - Defined Jekyll site settings including theme and SEO plugin.

### Changed

- **`README.md`**
  - Replaced deprecated `<center>` HTML tag with semantic `<p align="center">` for the logo block.
  - Updated image path to reflect asset relocation.

- **`TSNotion_mini.png`**
  - Removed from the project root and relocated to `assets/TSNotion_mini.png` for better directory structure.


## [0.5.0] - 2025-06-15

### Added

- **VSCode Configuration**
  - `.vscode/settings.json`: Configured `terminal.integrated.bracketedPasteMode`, disabled minimap, custom terminal profile, formatter preferences, and extension settings.
  - `.vscode/profile.ps1`: PowerShell profile to auto-import the module during VSCode sessions.
  - `.vscode/vsicons-custom-icons/`: Support for custom icons, including `file_type_pester.svg` and `copyFileToSystemPath.ps1`.

- **Build and Wiki Scripts**
  - `.build/Copy-WikiContent.ps1`: Script to copy wiki content from source to destination with flattened structure.
  - `.build/New-WikiSidebarFromPs1.ps1`: Generates `_Sidebar.md` from PowerShell and Markdown files.
  - `.build/README.md`: Documentation for adding custom build tasks and workflows.
  - `build.yaml`: Added `minibuild` task with steps for `Clean`, `Build_Module_ModuleBuilder`, and `Build_NestedModules_ModuleBuilder`.

- **Module Source Code**
  - `source/Classes/03_File/01_notion_file.ps1`: Static `Create` method to instantiate child objects based on file type.
  - `source/Classes/Block/RichText/01_Rich_Text.ps1`: `ConvertFromObjects` method to convert arrays or single objects into `rich_text[]`.
  - Various block classes (`Bookmark`, `Callout`, `ChildPage`, `Code`, `Image`, `Video`, etc.): New or refactored constructors, support for flexible input, `ConvertFromObject(s)` methods, support for `caption`, emoji, etc.
  - `source/Classes/Block/04_Block.ps1`: Improved error messages for unsupported and unknown block types with GitHub issue link.
  - `source/Classes/Emoji/01_emoji.ps1`: `ConvertFromObject` method to handle strings and emoji objects.
  - `source/Public/Block/New-NotionBlock.ps1`: Generic factory function to create Notion blocks.
  - `source/Public/Block/Cmds/*`: Many new cmdlets like `New-NotionBookmarkBlock`, `New-NotionCalloutBlock`, etc.
  - `docs/Enums/`: Markdown documentation for all enums used in the module.
  - `source/WikiSource/`: Wiki source files including setup guide, FAQ, and integration images.

- **Tests**
  - `tests/Integration/Block/testpage.tests.ps1`: Improved logic and error message validation.
  - `tests/Integration/PageProperties/testpage.tests.ps1`: Validation for page property types.
  - `tests/Unit/Classes/Block/`: Unit tests for many block classes.
  - Additional tests for new constructors, block types, and unsupported block error messages.

### Changed

- **General Refactoring**
  - Refactored many constructors across block classes to support more flexible input and consistent use of `ConvertFromObjects`.
  - `source/Classes/Emoji/01_emoji.ps1`: Improved emoji conversion logic.
  - `source/Enum/*`: Added missing enum values and documentation links.

- **Configuration Files**
  - `.vscode/analyzersettings.psd1`: Relaxed some analyzer rules (e.g., allowed `Write-Host`).
  - `.github/ISSUE_TEMPLATE/`: Updated templates to reflect support for cmdlets, classes, and enums.
  - `README.md`: Added badges, logo, and improved getting started section.
  - `RequiredModules.psd1`: Switched to Pester Version 6.
  - `build.ps1`: Added tasks `Generate_Wiki_Sidebar_From_Ps1` and `Copy_Wiki_Content_Custom`.

### Fixed

- **Class Fixes**
  - `source/Enum/01_notion_color.ps1`: Added `default_background` color.
  - `source/Classes/Block/32_Toggle.ps1`: Fixed class name and constructor.
  - `source/Classes/Block/33_Video.ps1`: Fixed constructors and file instantiation logic.
  - `source/Classes/Block/05_Bookmark.ps1`: Fixed constructors and `bookmark_structure` logic.
  - `source/Classes/Block/07_Bulleted_List_Item.ps1`: Fixed `rich_text` conversion in constructors.
  - `source/Classes/Block/08_Callout.ps1`: Fixed constructors and emoji handling.
  - `source/Classes/Emoji/01_emoji.ps1`: Fixed `ConvertFromObject` to handle strings and emoji objects.

- **Tests and Validation**
  - Improved error handling and validation in integration tests.
  - Enhanced input validation to prevent runtime errors.
  - Fixed `ConvertTo-Json` depth handling for complete serialization.
  - Fixed enum handling and added missing values.

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
