 # Title
  Short Description 
 
- [ ] Connect-TSNotion -BearerToken -notionUri  -ApiKey
- [ ] Connect-TSNotion -Profile
- Get-TSNotionPage
- Get-TSNotionPageContent (Get-TSNotionBlockChildren)


- https://github.com/makenotion/notion-sdk-js/blob/main/examples/intro-to-notion-api/intermediate/2-add-page-to-database.js


Invoke-TSNotionWebrequest

# ConvertTo-TSNotionObject
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
type        : block
block       : 
request_id  : 414efe1f-72a4-4592-83fb-a73aabe30134

#### $result.results

object           : block
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

object           : block
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
