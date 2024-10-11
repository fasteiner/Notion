class pp_multi_select : pp_multi_select_item
# https://developers.notion.com/reference/page-property-values#multi-select
{
    [pp_multi_select_item[]] $multi_select

    pp_multi_select($color, $name)
    {
        $this.multi_select = [pp_multi_select_item]::new($color, $name)
    }

    add($color, $name)
    {
        $this.multi_select += [pp_multi_select_item]::new($color, $name)
    }

    static [pp_multi_select] ConvertFromObject($Value)
    {
        if ($Value -is [string])
        {
            return [pp_multi_select]::new($Value)
        }
        if ($Value -is [object[]])
        {
            $multi_select = @()
            foreach ($item in $Value)
            {
                $multi_select += [pp_multi_select_item]::new($item.color, $item.name)
            }
            return [pp_multi_select]::new($multi_select)
        }
    }
}
