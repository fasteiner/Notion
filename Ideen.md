 # Title
  Short Description 
 
- [X] Connect-Notion -BearerToken -notionUri  -ApiKey
- [ ] Connect-Notion -Profile
- [ ] Connect-Notion Errorhandling/Output bei falschem Bearer Token
- Get-NotionPage
- Get-NotionPageContent (Get-NotionBlockChildren)

- https://github.com/makenotion/notion-sdk-js/blob/main/examples/intro-to-notion-api/intermediate/2-add-page-to-database.js

Invoke-NotionWebrequest

# Naming Convention
To prevent name conflicts, use the NoClobber or Prefix parameters of the Import-Module cmdlet. The Prefix parameter adds a prefix to the names of imported commands so that they're unique in the session. The NoClobber parameter doesn't import any commands that would hide or replace existing commands in the session.

You can also use the Alias, Cmdlet, Function, and Variable parameters of Import-Module to select only the commands that you want to import, and you can exclude commands that cause name conflicts in your session.

Module authors can prevent name conflicts by using the DefaultCommandPrefix property of the module manifest to add a default prefix to all command names. The value of the Prefix parameter takes precedence over the value of DefaultCommandPrefix.

--------------------------------------------------------------------------------------------------------------------------------------------------------------------
# ConvertTo-NotionObject
## Top-level resources have an "object" property. This property can be used to determine the type of the resource (e.g. "database", "user", etc.)
## https://developers.notion.com/reference/intro

#### Invoke-RestMethod -Uri "https://api.notion.com/v1/pages/5158893eac8b4f719c8b49b99596adb7" 

object           : page
id               : 5158893e-ac8b-4f71-9c8b-49b99596adb7
created_time     : 25.10.2023 18:56:00
last_edited_time : 28.01.2024 18:45:00
created_by       : @{object=user; id=35ac37f4-22a5-484c-8bec-6e21a921d5fd}
last_edited_by   : @{object=user; id=35ac37f4-22a5-484c-8bec-6e21a921d5fd}
cover            : 
icon             : 
parent           : @{type=page_id; page_id=498089df-26d3-4161-8e5e-096cc5805806}
archived         : False
in_trash         : False
properties       : @{title=}
url              : https://www.notion.so/PStest-5158893eac8b4f719c8b49b99596adb7
public_url       : 
request_id       : 4f30a012-28f3-4270-aaf4-dbc9b54af6d9

#### Invoke-RestMethod -Uri "https://api.notion.com/v1/blocks/5158893eac8b4f719c8b49b99596adb7/children"
## Endpoints that return lists of objects 
object      : list
results     : {@{object=block; id=f0e66433-9fc3-4e09-b232-a970081b03fe; parent=; created_time=25.10.2023 18:57:00; last_edited_time=25.10.2023 19:05:00; created_by=; last_edited_by=; has_children=True; archived=False; in_trash=False; type=table; table=}, @{object=block;
              id=7bd1d45f-5139-4840-93e5-1bd2f3833d83; parent=; created_time=25.10.2023 19:04:00; last_edited_time=25.10.2023 19:04:00; created_by=; last_edited_by=; has_children=False; archived=False; in_trash=False; type=paragraph; paragraph=}, @{object=block;
              id=a99b97b0-20ba-4b01-a8d8-596ff37c72fa; parent=; created_time=25.10.2023 19:49:00; last_edited_time=25.10.2023 19:49:00; created_by=; last_edited_by=; has_children=False; archived=False; in_trash=False; type=heading_2; heading_2=}, @{object=block;
              id=6a9ed790-d777-4ed9-8db6-5e7c25356e5d; parent=; created_time=25.10.2023 19:49:00; last_edited_time=25.10.2023 19:49:00; created_by=; last_edited_by=; has_children=False; archived=False; in_trash=False; type=paragraph; paragraph=}…}
next_cursor : 
has_more    : False
type        : notion_block
block       : 
request_id  : 414efe1f-72a4-4592-83fb-a73aabe30134

#### $result.results

object           : notion_block
id               : f0e66433-9fc3-4e09-b232-a970081b03fe
parent           : @{type=page_id; page_id=5158893e-ac8b-4f71-9c8b-49b99596adb7}
created_time     : 25.10.2023 18:57:00
last_edited_time : 25.10.2023 19:05:00
created_by       : @{object=user; id=35ac37f4-22a5-484c-8bec-6e21a921d5fd}
last_edited_by   : @{object=user; id=35ac37f4-22a5-484c-8bec-6e21a921d5fd}
has_children     : True
archived         : False
in_trash         : False
type             : table
table            : @{table_width=2; has_column_header=True; has_row_header=False}

object           : notion_block
id               : 7bd1d45f-5139-4840-93e5-1bd2f3833d83
parent           : @{type=page_id; page_id=5158893e-ac8b-4f71-9c8b-49b99596adb7}
created_time     : 25.10.2023 19:04:00
last_edited_time : 25.10.2023 19:04:00
created_by       : @{object=user; id=35ac37f4-22a5-484c-8bec-6e21a921d5fd}
last_edited_by   : @{object=user; id=35ac37f4-22a5-484c-8bec-6e21a921d5fd}
has_children     : False
archived         : False
in_trash         : False
type             : paragraph
paragraph        : @{rich_text=System.Object[]; color=default}

[...]

# Exporting classes with type accelerators
https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_classes?view=powershell-7.4#exporting-classes-with-type-accelerators
By default, PowerShell modules don't automatically export classes and enumerations defined in PowerShell. The custom types aren't available outside of the module without calling a using module statement.


## Wie befüllen wir das Array der exportierbaren Classes?
(Sampler Q&A: Exporting classes with type accelerators)[https://github.com/gaelcolas/Sampler/discussions/493]
  $ExportableTypes =@(
      [plane]
  )


  [ ] New-NotionBlock


# PageProperties
Page Properties müssen im Zuge der [notion_page]::ConvertFromObject mitberücksichtig und in echte Klassen konvertiert werden!!! (Dort sind in der DB die Daten drinnen)


## DB Row = Page, Properties = Daten
$pageClass3.properties

Ordernumber     : @{id=C%3E%3FU; type=number; number=10000}
Comment         : @{id=EuKy; type=rich_text; rich_text=System.Object[]}
Tags            : @{id=G%7CXt; type=multi_select; multi_select=System.Object[]}
Telefon         : @{id=INcy; type=phone_number; phone_number=+43 1 234567890}
Bestellvariante : @{id=MTPa; type=select; select=}
ArtikelNummer   : @{id=Zv%5By; type=rich_text; rich_text=System.Object[]}
Orderdate       : @{id=%5Byc%3C; type=date; date=}
Geschlecht      : @{id=%5CEp%7D; type=select; select=}
Nachname        : @{id=%5Dt%7Cy; type=rich_text; rich_text=System.Object[]}
Anwesend        : @{id=ch%3Di; type=checkbox; checkbox=True}
E-Mail          : @{id=dBvC; type=email; email=hansi.huber@gmail.com}
Bezahlstatus    : @{id=lqUd; type=select; select=}
Vorname         : @{id=title; type=title; title=System.Object[]}
# Tests

## Test Connect-Notion with BearerToken, notionUri, and ApiKey
