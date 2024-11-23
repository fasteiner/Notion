# Welcome to the TSNotion wiki

<sup>*TSNotion v#.#.#*</sup>

Here you will find all the information you need to use TSNOtion.

Please leave comments, feature requests, and bug reports for this module in
the [issues section](https://github.com/xxx/TSNotion/issues)
for this repository.

## Getting started

To get started either:

- Install from the PowerShell Gallery using PowerShellGet by running the
  following command:

```powershell
Install-Module -Name TSNotion -Repository PSGallery
```

## Prerequisites

- PowerShell 7 or higher

## Idea behind a class based Notion module

There are several attepts to talkto the Notion API out there, but most of them din't take care of the correct 
syntax of the individual configuration of each block/page/database etc. So I decided to create classes for all 
available Notion objects presented by the API. (there are some objects which ar not available right now - 
end of 2024 like e.g. template)

The charm of Notion classes are thies simple use while creating objects.
```
[notion_block]::new() # creates an empty block object
[notion_page]::new()  # creates a new page object
```
If you receive items from the API, TSNotion will automatically convert it into Notion objects 
(based on the classes) so that the can be used.

## Change log

A full list of changes in each version can be found in the [change log](https://github.com/xxx/TSNotion/blob/main/CHANGELOG.md).
