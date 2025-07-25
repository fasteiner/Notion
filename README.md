<p align="center">
  <img src="assets/TSNotion_mini.png" alt="Notion Module Logo" width="150"/>
</p>

# Notion - A class-based PowerShell module for interacting with Notion


[![PowerShell Gallery Version](https://img.shields.io/powershellgallery/v/Notion?label=PSGallery%20Version)](https://www.powershellgallery.com/packages/Notion/)
[![PowerShell Gallery Downloads](https://img.shields.io/powershellgallery/dt/Notion?label=Downloads)](https://www.powershellgallery.com/packages/Notion/)
![Platform](https://img.shields.io/badge/Platform-Windows|Linux|MacOS-blue)
[![GitHub Issues](https://img.shields.io/github/issues/fasteiner/Notion?label=Issues)](https://github.com/fasteiner/Notion/issues)

&#x26a0; Work in progress - not all features are implemented yet, if you are missing something, or experience any issues, please open an issue on GitHub.

[Notion](https://notion.com), is an online knowledge management tool in which you can structure your requirements yourself or be inspired by countless templates and formats. Unfortunately, there was no PowerShell module that offers the full power of the API.

In order to ensure the smoothest possible interaction with the API, the specifications were implemented with PowerShell classes. This means that classes are used in the background for all cmdlets. You can also create your own Notion objects directly using the classes provided.

## Prerequisites

- PowerShell 7.0 or higher

## Getting started

To get started either:

- Install from the PowerShell Gallery using PowerShellGet by running the
  following command:

```PowerShell
# PowerShellGet 2.x
Install-Module -Name Notion -Repository PSGallery

# PowerShellGet 3.x
Install-PSResource -Name Notion

# Connect to Notion
$BearerToken = Read-Host -Prompt "Enter your Notion Bearer Token" -AsSecureString
Connect-Notion -BearerToken $BearerToken
```

Or download it via the [Microsoft PowerShell Gallery](https://www.powershellgallery.com/packages/Notion)

## Documentation

Documentation is available in the [Wiki](https://github.com/fasteiner/Notion/wiki).

## Issues

Please open a github issue [here](https://github.com/fasteiner/Notion/issues).
