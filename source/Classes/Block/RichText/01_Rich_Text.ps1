class rich_text
# https://developers.notion.com/reference/rich-text
{
    [notion_rich_text_type] $type
    # object: text / mention / equation
    [notion_annotation] $annotations
    [string] $plain_text = $null
    $href = $null

    # empty rich text object
    # [rich_text]::new()
    rich_text()
    {

    }
    rich_text([string] $type)
    {
        $this.type = [Enum]::Parse([notion_rich_text_type], $type)
    }

    rich_text([notion_rich_text_type] $type)
    {
        $this.type = $type
    }

    # rich text object with content and annotations
    # [rich_text]::new("Hallo", [notion_annotation]::new())
    #BUG ?? sollte das nicht mit test moeglich sein ??
    rich_text([notion_rich_text_type] $type, [notion_annotation] $annotations)
    {
        $this.type = $type
        $this.annotations = $annotations
    }
    rich_text([notion_rich_text_type] $type, [notion_annotation] $annotations, [string] $plain_text)
    {
        if ($plain_text.Length -gt 2000)
        {
            throw [System.ArgumentException]::new("The plain text must be 2000 characters or less.")
        }
        $this.type = $type
        $this.annotations = $annotations
        $this.plain_text = $plain_text
    }
    
    rich_text([notion_rich_text_type] $type, [notion_annotation] $annotations, [string] $plain_text, $href)
    {
        if ($plain_text.Length -gt 2000)
        {
            throw [System.ArgumentException]::new("The plain text must be 2000 characters or less.")
        }
        if ($href.Length -gt 2000)
        {
            throw [System.ArgumentException]::new("The href must be 2000 characters or less.")
        }
        $this.type = $type
        $this.annotations = $annotations
        $this.plain_text = $plain_text
        $this.href = $href
    }

    static [rich_text] Create([string] $type = "text", $annotations = $null, [object] $content = "", $href = $null)
    {
        if ($content -is [string] -and $content.Length -gt 2000)
        {
            throw [System.ArgumentException]::new("The content must be 2000 characters or less.")
        }
        switch($type)
        {
            "text"
            {
                return [rich_text_text]::new($annotations, $content, $href)
            }
            "mention"
            {
                # not implemented exeption
                throw [System.NotImplementedException]::new("Rich text mention creation is not implemented yet.") 
            }
            "equation"
            {
                $equation = [rich_text_equation]::new($content)
                $equation.href = $href
                if ($annotations)
                {
                    $equation.annotations = $annotations
                }
                return $equation
            }
            default
            {
                throw [System.ArgumentException]::new("Invalid rich text type: $type")
            }
        }
        return $null
    }

    static [rich_text[]] ConvertFromMarkdown([string] $markdownInput)
    {
        #TODO: test
        $resultList = @()
        $regexPattern = '(\$\$(.+?)\$\$|\\\((.+?)\\\)|\*\*(.+?)\*\*|\*(.+?)\*|`(.+?)`|\[(.+?)\]\((.+?)\)|@(\w+)|([^*`@$\[]+))'
        $matches = [regex]::Matches($markdownInput, $regexPattern)

        foreach ($match in $matches)
        {
            $annotationObj = [notion_annotation]::new()
            $textContent = $null
            $linkTarget = $null

            if ($match.Groups[2].Success -or $match.Groups[3].Success)
            {
                # LaTeX
                $latexExpr = $match.Groups[2].Value
                if (-not $latexExpr)
                {
                    $latexExpr = $match.Groups[3].Value 
                }
                $resultList += [rich_text_equation]::new($latexExpr)
                continue
            }
            elseif ($match.Groups[4].Success)
            {
                $textContent = $match.Groups[4].Value
                $annotationObj.bold = $true
            }
            elseif ($match.Groups[5].Success)
            {
                $textContent = $match.Groups[5].Value
                $annotationObj.italic = $true
            }
            elseif ($match.Groups[6].Success)
            {
                $textContent = $match.Groups[6].Value
                $annotationObj.code = $true
            }
            elseif ($match.Groups[7].Success -and $match.Groups[8].Success)
            {
                $textContent = $match.Groups[7].Value
                $linkTarget = $match.Groups[8].Value
            }
            elseif ($match.Groups[9].Success)
            {
                $mentionName = $match.Groups[9].Value
                $mentionObj = [rich_text_mention_user]::new($mentionName)  # Beispiel: User-Mention
                $mentionRichText = [rich_text_mention]::new("user")
                $mentionRichText.mention = $mentionObj
                $mentionRichText.plain_text = "@$mentionName"
                $resultList += $mentionRichText
                continue
            }
            elseif ($match.Groups[10].Success)
            {
                $textContent = $match.Groups[10].Value
            }

            if ($textContent)
            {
                $richTextObj = [rich_text]::new("text", $annotationObj, $textContent)
                if ($linkTarget)
                {
                    $richTextObj.href = $linkTarget 
                }
                $resultList += $richTextObj
            }
        }

        return $resultList
    }



    static [rich_text[]] ConvertFromObjects([object] $Value)
    {
        if ($Value -isnot [array])
        {
            $Value = @($Value)
        }
        $output = @()
        foreach ($item in $Value)
        {
            if ($item -isnot [rich_text])
            {
                if ($item -is [string])
                {
                    if ($item.Length -gt 0)
                    {
                        # Convert string to rich_text_text
                        $item = [rich_text_text]::new($item)
                    }
                    else
                    {
                        $item = $null
                    }
                }
                else
                {
                    $item = [rich_text]::ConvertFromObject($item)
                }
            }
            $output += $item
        }
        return $output
    }


    static [rich_text] ConvertFromObject($Value)
    {
        Write-Verbose "[rich_text]::ConvertFromObject($($Value | ConvertTo-Json))"
        if (!$Value.type)
        {
            return $null
        }
        if ($Value -is [rich_text])
        {
            return $Value
        }
        if ($Value -is [string])
        {
            if ($Value.Length -gt 0)
            {
                # Convert string to rich_text_text
                return [rich_text_text]::new($Value)
            }
            else
            {
                return $null
            }
        }
        $rich_text = $null
        switch ($Value.type)
        {
            "text"
            {
                $rich_text = [rich_text_text]::ConvertFromObject($Value)
                break
            }
            "mention"
            {
                $rich_text = [rich_text_mention]::ConvertFromObject($Value)
                break
            }
            "equation"
            {
                $rich_text = [rich_text_equation]::ConvertFromObject($Value)
                break
            }
            default
            {
                Write-Error "Unknown rich text type: $($Value.type)" -Category InvalidData -TargetObject $Value -RecommendedAction "Please provide a valid rich text type (text, mention or equation)"
            }
        }
        $local:annotations = [notion_annotation]::ConvertFromObject($Value.annotations)
        if ($local:annotations)
        {
            $rich_text.annotations = $local:annotations
        }
        $rich_text.plain_text ??= $Value.plain_text
        $rich_text.href = $Value.href
        return $rich_text
    }
}
