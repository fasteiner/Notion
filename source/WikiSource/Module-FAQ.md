# HowTo


### How to get started?
* [How to obtain an Bearer Token / Notion API Key / Integration Key?](# How to obtain an Bearer Token / Notion API Key / Integration Key?)
* ```Install-Module Notion```
* ```Import-Module Notion```
* [How to connect for the first time?](# How to connect for the first time?)


## How to obtain an Bearer Token / Notion API Key / Integration Key?
    1. Register a new account at [https://notion.com](https://notion.com)
    2. [https://developers.notion.com](https://developers.notion.com) -> Click "View my integrations"
    3. At My integrations click Add (**+**)
    4. Select the name, workspace, type and logo - Click Save
    5. Click on "Configure"
    6. Secret -> Click on "Show"
    7. Click on "Copy"
    8. That's your Bearer Token / API Key / Integration Token

## How to connect for the first time?

```
$BearerToken = Read-Host -Prompt "Enter your Bearer token" | ConvertTo-Securestring -AsPlainText
Connect-Notion -BearerToken $BearerToken
```

## How to get an existing page content?

    1. Browse to you Notion page (e.g. https://www.notion.so/My-TestPage-0123456789A1234567890)
    2. Copy the Id of the page (the alphanumerical part after the page name e.g. 0123456789A1234567890)
    3. ```Get-NotionPage -PageId 0123456789A1234567890```
    4. You will receive an Notion object containing the blocks of the page

## How to get an existing page properties?

    1. Browse to you Notion page (e.g. https://www.notion.so/My-TestPage-0123456789A1234567890)
    2. Copy the Id of the page (the alphanumerical part after the page name e.g. 0123456789A1234567890)
    3. ```Get-NotionPageProperties -PageId 0123456789A1234567890```

## How to list existing pages?

## How to add a new page?

## How to add a new block to a page?

## How to generate page content?
