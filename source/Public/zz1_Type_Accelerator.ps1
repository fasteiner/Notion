# Define the types to export with type accelerators.
$ExportableTypes = @(
    # enums
    [notion_rich_text_type]
    [notion_blocktype]
    [notion_database_property_type]
    #[relation_type]
    [notion_database_property_format_type]
    [notion_filetype]
    [notion_page_property_type]
    [notion_property_color]
    [notion_formula_type]
    [notion_rollup_type]
    [notion_rollup_function_type]
    [notion_page_verification_state]
    [notion_parent_type]
    [bot_owner_type]
    [notion_color]
    [notion_icon_type]
    [rich_text_mention_type]
    
    [template_mention_date]
    
    # classes
    [notion_annotation]
    [notion_heading_block]
    [notion_heading_1_block]
    [notion_heading_2_block]
    [notion_heading_3_block]
    
    [notion_block]
    [notion_bookmark_block]
    [notion_bot_user]
    [notion_breadcrumb_block]
    [notion_bulleted_list_item_block]
    [notion_callout_block]
    [notion_checkbox_page_property]
    [notion_child_database_block]
    [notion_child_page_block]
    [notion_code_block]
    [notion_column_block]
    [notion_column_list_block]
    [notion_comment]
    [notion_created_by_page_property]
    [notion_created_time_page_property]
    [notion_custom_emoji]
    [notion_database]
    [notion_databaseproperties]
    [notion_date_page_property]
    [notion_divider_block]
    [notion_email_page_property]
    [notion_embed_block]
    [notion_emoji]
    [notion_equation_block]
    [notion_external_file]
    [notion_file]
    [notion_file_block]
    [notion_files_page_property]
    [notion_formula_page_property]
    [notion_hosted_file]
    [notion_image_block]
    [notion_last_edited_by_page_property]
    [notion_last_edited_time_page_property]
    [notion_link_preview_block]
    [notion_multi_select_item]
    [notion_multi_select_page_property]
    [notion_number_page_property]
    [notion_numbered_list_item_block]
    [notion_page]
    [notion_icon]
    [notion_pageproperties]
    [notion_paragraph_block]
    [notion_parent]
    [notion_database_parent]
    [notion_page_parent]
    [notion_block_parent]
    [notion_workspace_parent]
    [notion_PDF_block]
    [notion_people_page_property]
    [notion_people_user]
    [notion_phone_number_page_property]
    [notion_quote_block]
    [notion_relation_page_property]
    [notion_rich_text_page_property]
    [notion_rollup_page_property]
    [notion_section_unfurl_attribute]
    [notion_select_page_property]
    [notion_status_page_property]
    [notion_sub_type_child_unfurl_attribute]
    [notion_sub_type_unfurl_attribute]
    [notion_synced_block]
    [notion_table_of_contents_block]
    [notion_table_row_block]
    [notion_table_block]
    [notion_title_page_property]
    [notion_to_do_block]
    [notion_toggle_block]
    [notion_unique_id_page_property]
    [notion_url_page_property]
    [notion_user]
    [notion_verification_page_property]
    [notion_video_block]

    #rich text
    [rich_text]
    [rich_text_equation]
    [rich_text_equation_structure]
    [rich_text_mention]
    [rich_text_mention_base]
    [rich_text_mention_database]
    [rich_text_mention_database_structure]
    [rich_text_mention_date]
    [rich_text_mention_date_structure]
    [rich_text_mention_link_preview]
    [rich_text_mention_page]
    [rich_text_mention_page_structure]
    [rich_text_mention_template_mention]
    [rich_text_mention_template_mention_structure_base]
    [rich_text_mention_template_mention_template_mention_date_structure]
    [rich_text_mention_template_mention_template_mention_user_structure]
    [rich_text_mention_user]
    [rich_text_text]
    [rich_text_text_structure]

    # TODO: remove before release
    [PagePropertiesBase]
)
