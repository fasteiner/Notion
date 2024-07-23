# HowTo


### How to get started?
* [How to obtain an Bearer Token / Notion API Key / Integration Key?](# How to obtain an Bearer Token / Notion API Key / Integration Key?)
* ```Install-Module TSNotion```
* ```Import-Module TSNotion```
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
Connect-TSNotion -BearerToken $BearerToken
```

## How to list existing pages?

## How to add a new page?

## How to add a new block to a page?
