# Copilot Instructions for Notion PowerShell Module

## Project Overview
- This is a class-based PowerShell module for interacting with the Notion API, designed for cross-platform use (Windows, Linux, MacOS).
- All cmdlets are backed by PowerShell classes, enabling direct creation and manipulation of Notion objects.
- The module structure mirrors Notion's API objects: `source/Classes` contains class definitions, with subfolders for each Notion object type (Block, Page, Database, etc.).
- All comments and documentation should be in English.
- Database and page properties are implemented as individual classes, often prefixed with numbers to enforce load order (see `README_numbering.md`).
- The project keeps a changelog in `CHANGELOG.md`, using [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) format, which should be updated with each change.

## Build & Test Workflows
- **Build:** Use `./build.ps1` for all build and CI/CD tasks. It supports dependency resolution, code coverage, and module packaging.
  - Example: `./build.ps1 -Tasks build -ResolveDependency -UseModuleFast`
- **Test:** Run tests via the build script or dedicated tasks:
  - Example: `./build.ps1 -Tasks test -AutoRestore`
  - Unit, integration, and QA tests are in `tests/Unit`, `tests/Integration`, and `tests/QA`.
- **Dependencies:** Managed via `RequiredModules.psd1` and `Resolve-Dependency.psd1`. The preferred method is PSResourceGet, but ModuleFast is supported for faster resolution.
- **Manual Import:** After build, import the module from the output directory using the versioned path (see CONTRIBUTING.md for details).

## Key Conventions & Patterns
- **Class Loading Order:** Number prefixes in class filenames (e.g., `00_`, `01_`) ensure correct inheritance and load order.
- **Property Objects:** Database and page properties are implemented as distinct classes due to major differences in Notion's API (see `TODO_Properties.md`).
- **Documentation:** Markdown docs for each class and enum are in `docs/Classes` and `docs/Enums`. Wiki content is generated from source via build tasks.
- **API Integration:** All Notion API calls are wrapped in cmdlets under `source/Public/Invoke-NotionApiCall.ps1` and related files.
- **External Dependencies:** Uses PowerShell modules like `InvokeBuild`, `Pester`, `ModuleBuilder`, and others listed in `RequiredModules.psd1`.

## Common Tasks & Examples
- **Connect to Notion:**
  ```powershell
  $BearerToken = Read-Host -Prompt "Enter your Notion Bearer Token" -AsSecureString
  Connect-Notion -BearerToken $BearerToken
  ```
- **Run Tests:**
  ```powershell
  ./build.ps1 -Tasks test -AutoRestore
  ```
- **Build & Import:**
  ```powershell
  ./build.ps1 -Tasks build -ResolveDependency -UseModuleFast
  $version = (dotnet-gitversion.exe /showvariable MajorMinorPatch)
  $ModuleFile = ".\output\module\Notion\$version\Notion.psd1"
  Import-Module $ModuleFile
  ```

## Coding Practices
- **Approved Verbs:** Only use PowerShell approved verbs in cmdlet names (e.g., `Get-`, `Set-`, `New-`, `Remove-`).
- **Documentation:** Write line comments to describe code and generate comment-based documentation in functions above the params block.
- **Parameter Conventions:**
  - ID properties should always be the first positional parameter
  - When a parameter name is `<resource>ID`, add an `ID` alias
  - Use descriptive variable names
- **PowerShell Best Practices:**
  - Use `.Where()` method instead of `Where-Object` pipeline
  - Prefer typed variables and class definitions for strongly-typed objects
  - Use region comments for code organization (`#region Parameters`, `#region Main`, etc.) in long scripts
  - Use `ShouldProcess` and `ConfirmImpact` in destructive functions (e.g., disconnects, deletes)
  - Use `Write-Verbose`, `Write-Progress` (for longer running commands), and `Write-Warning` appropriately
  - Always prefer singular noun verbs (`Get-User`, not `Get-Users`)
  - Implement parameter sets when different input types are expected (e.g., `-Id` vs `-Hostname`)
  - Use `[CmdletBinding()]` and `param()` blocks
  - Always specify a recommended action on `Write-Error`
  - Always add a Output type (e.g., `[OutputType([ClassName])]`)

## Testing Practices
- Structure classes should not be tested explicitly (only through the provided interface), as they are non-exportable
- For testing errors (`Should -Throw`), ensure that we are in Module Context (`InModuleScope -ModuleName $global:moduleName { ... }`)
- For checking if non-exportable classes have the correct type use: `$variable.GetType().Name | Should -Be "class_name"`
- Use Pester 6 Syntax throughout all tests

## References
- [README.md](../README.md): Project intro and getting started
- [CONTRIBUTING.md](../CONTRIBUTING.md): Branching, build, and test details
- [RequiredModules.psd1](../RequiredModules.psd1), [Resolve-Dependency.psd1](../Resolve-Dependency.psd1): Dependency management
- [docs/Classes](../docs/Classes), [docs/Enums](../docs/Enums): API/class documentation
- [source/Public](../source/Public): Cmdlet entry points

---
If any section is unclear or missing key patterns, please provide feedback to improve these instructions.
