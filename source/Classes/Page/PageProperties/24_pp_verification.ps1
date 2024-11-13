class notion_verification
# https://developers.notion.com/reference/page-property-values#verification
{
    [notion_page_verification_state] $state
    [user] $verified_by
    [string] $date

    #Constructors
    notion_verification_page_property($Value)
    {
        $this.state = [Enum]::Parse([notion_page_verification_state], $Value.state)
        $this.verified_by = [user]::new($Value.verified_by)
        $this.date = Get-Date $Value.date -Format "yyyy-MM-ddTHH:mm:ss.fffZ"
    }

    notion_verification_page_property($state, $verified_by, $date)
    {
        $this.state = [Enum]::Parse([notion_page_verification_state], $state)
        $this.verified_by = [user]::new($verified_by)
        $this.date = Get-Date $date -Format "yyyy-MM-ddTHH:mm:ss.fffZ"
    }

    #Methods
    static [notion_verification_page_property] ConvertFromObject($Value)
    {
        return [notion_verification_page_property]::new($Value.state, $Value.verified_by, $Value.date)
    }
}

class notion_verification_page_property : PagePropertiesBase{
    [notion_verification] $verification

    notion_verification_page_property() : base("verification")
    {
        $this.verification = [notion_verification]::new()
    }

    notion_verification_page_property($state, $verified_by, $date) : base("verification")
    {
        $this.verification = [notion_verification]::new($state, $verified_by, $date)
    }

    static [notion_verification_page_property] ConvertFromObject($Value)
    {
        return [notion_verification_page_property]::new($Value.verification.state, $Value.verification.verified_by, $Value.verification.date)
    }
}
