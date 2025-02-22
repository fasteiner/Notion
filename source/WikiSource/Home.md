# Welcome to the Notion wiki

<sup>_Notion v#.#.#_</sup>

Here you will find all the information you need to use Notion.

Please leave comments, feature requests, and bug reports for this module in
the [issues section](https://github.com/fasteiner/Notion/issues)
for this repository.

## Idea behind a class based Notion module

There are several attepts to talkto the Notion API out there, but most of them din't take care of the correct
syntax of the individual configuration of each block/page/database etc. So I decided to create classes for all
available Notion objects presented by the API. (there are some objects which ar not available right now -
end of 2024 like e.g. template)

The charm of Notion classes are thies simple use while creating objects.

``` PowerShell
[notion_block]::new() # creates an empty block object
[notion_page]::new()  # creates a new page object
```

If you receive items from the API, Notion will automatically convert it into Notion objects
(based on the classes) so that the can be used.

## Notion Objects

There are several type of Notion object for different purposes.

- Block
- Page
- Database
- Parent
- User
- Comment
- Unfurl attribute
- File
- Emoji

Each of the objects have got individual CmdLets to deal with.
<div style="display: flex;">

  <table>
  <tr><th>Object: Block</th></tr>
  <tr><td>Add-NotionBlockToPage</td></tr>
  <tr><td>Get-NotionBlock</td></tr>
  <tr><td>Get-NotionBlockChildren</td></tr>
  </table>

  <table>
  <tr><th>Object: Database</th></tr>
  <tr><td>Add-NotionPageToDatabase</td></tr>
  <tr><td>Edit-NotionDatabase</td></tr>
  <tr><td>Get-NotionDatabase</td></tr>
  <tr><td>Move-NotionDatabaseToArchive</td></tr>
  <tr><td>New-NotionDatabase</td></tr>
  <tr><td>Remove-NotionDatabase</td></tr>
  <tr><td>Restore-NotionDatabase</td></tr>
  </table>

  <table>
  <tr><th>Object: DatabaseProperties</th></tr>
  <tr><td>Add-NotionDatabaseProperty</td></tr>
  <tr><td>New-NotionDatabaseProperty</td></tr>
  <tr><td>Remove-NotionDatabaseProperty</td></tr>
  </table>

</div>

<div style="display: flex;">

  <table>
  <tr><th>Object: Page</th></tr>
  <tr><td>Get-NotionPage</td></tr>
  <tr><td>Get-NotionPageChildren</td></tr>
  <tr><td>Move-NotionPageToArchive</td></tr>
  <tr><td>New-NotionPage</td></tr>
  <tr><td>Remove-NotionPage</td></tr>
  <tr><td>Restore-NotionPage</td></tr>
  </table>

  <table>
  <tr><th>Object: PageProperties</th></tr>
  <tr><td>Get-NotionPageProperty</td></tr>
  <tr><td>Update-NotionPageProperty</td></tr>
  </table>
</div>

<div style="display: flex;">

  <table>
  <tr><th>Object: User</th></tr>
  <tr><td>Get-NotionUser</td></tr>
  </table>

</div>

## Classes and Enums

An easy way to genrate new blocks is to instantiate them from predefined classes via `[classname]::new()`.
On the querying side the API returns a nacked object with properties. The module automatically turns those answers into proper Notion objects (derived from classes)

The enumerations (enums) are predefined values which are valid for a certain properties. e.g. colors

### Enums
- `[rich_text_type]`
- `[notion_blocktype]`
- `[notion_database_property_type]`
- `#[relation_type]`
- `[notion_database_property_format_type]`
- `[notion_filetype]`
- `[notion_page_property_type]`
- `[notion_property_color]`
- `[notion_formula_type]`
- `[notion_rollup_type]`
- `[notion_rollup_function_type]`
- `[notion_page_verification_state]`
- `[notion_parent_type]`
- `[bot_owner_type]`
- `[notion_color]`
- `[icontype]`
- `[rich_text_mention_type]`
- `[template_mention_date]`

### Classes
- `[annotation]`
- `[heading_1]`
- `[heading_2]`
- `[heading_3]`
- `[notion_block]`
- `[notion_bookmark_block]`
- `[notion_bot_user]`
- `[notion_breadcrumb_block]`
- `[notion_bulleted_list_item_block]`
- `[notion_callout_block]`
- `[notion_checkbox_page_property]`
- `[notion_child_database_block]`
- `[notion_child_page_block]`
- `[notion_code_block]`
- `[notion_column_block]`
- `[notion_column_list_block]`
- `[notion_comment]`
- `[notion_created_by_page_property]`
- `[notion_created_time_page_property]`
- `[notion_custom_emoji]`
- `[notion_database]`
- `[notion_databaseproperties]`
- `[notion_date_page_property]`
- `[notion_divider_block]`
- `[notion_email_page_property]`
- `[notion_embed_block]`
- `[notion_emoji]`
- `[notion_equation_block]`
- `[notion_external_file]`
- `[notion_file]`
- `[notion_file_block]`
- `[notion_files_page_property]`
- `[notion_formula_page_property]`
- `[notion_hosted_file]`
- `[notion_image_block]`
- `[notion_last_edited_by_page_property]`
- `[notion_last_edited_time_page_property]`
- `[notion_link_preview_block]`
- `[notion_multi_select_item]`
- `[notion_multi_select_page_property]`
- `[notion_number_page_property]`
- `[notion_numbered_list_item_block]`
- `[notion_page]`
- `[notion_icon]`
- `[notion_page_parent]`
- `[notion_pageproperties]`
- `[notion_paragraph_block]`
- `[notion_parent]`
- `[notion_page_parent]`
- `[notion_workspace_parent]`
- `[notion_PDF_block]`
- `[notion_people_page_property]`
- `[notion_people_user]`
- `[notion_phone_number_page_property]`
- `[notion_quote_block]`
- `[notion_relation_page_property]`
- `[notion_rich_text_page_property]`
- `[notion_rollup_page_property]`
- `[notion_section_unfurl_attribute]`
- `[notion_select_page_property]`
- `[notion_status_page_property]`
- `[notion_sub_type_child_unfurl_attribute]`
- `[notion_sub_type_unfurl_attribute]`
- `[notion_synced_block]`
- `[notion_table_of_contents_block]`
- `[notion_title_page_property]`
- `[notion_to_do_block]`
- `[notion_toggle_block]`
- `[notion_unique_id_page_property]`
- `[notion_url_page_property]`
- `[notion_user]`
- `[notion_verification_page_property]`
- `[notion_video_block]`
- `[rich_text]`
- `[rich_text_equation]`
- `[rich_text_equation_structure]`
- `[rich_text_mention]`
- `[rich_text_mention_base]`
- `[rich_text_mention_database]`
- `[rich_text_mention_database_structure]`
- `[rich_text_mention_date]`
- `[rich_text_mention_date_structure]`
- `[rich_text_mention_link_preview]`
- `[rich_text_mention_page]`
- `[rich_text_mention_page_structure]`
- `[rich_text_mention_template_mention]`
- `[rich_text_mention_template_mention_structure_base]`
- `[rich_text_mention_template_mention_template_mention_date_structure]`
- `[rich_text_mention_template_mention_template_mention_user_structure]`
- `[rich_text_mention_user]`
- `[rich_text_text]`
- `[rich_text_text_structure]`

## Change log

A full list of changes in each version can be found in the [change log](https://github.com/fasteiner/Notion/blob/main/CHANGELOG.md).
