# class rich_type_mention : Block
# # https://developers.notion.com/reference/rich-text#mention
# {
#     [blocktype] $type = "mention"
#     [mention_type] $mention
#     [bool] $mention
#     [rich_text[]] $rich_text
#     [notion_color] $color = "default"


#     static [rich_type_mention] ConvertFromObject($Value)
#     {
#         $rich_type_mention = [rich_type_mention]::new()
#         $rich_type_mention.mention = $Value.mention
#         $rich_type_mention.rich_text = [rich_text]::ConvertFromObject($Value.rich_text)
#         $rich_type_mention.color = [Enum]::Parse([notion_color], $Value.color)
#         return $rich_type_mention
#     }
# }
