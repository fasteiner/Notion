$a = @"
ndb_options
ndb_database
ndb_checkbox
ndb_created_by
ndb_created_time
ndb_dateProperty
ndb_date
ndb_email
ndb_files
ndb_formula
ndb_last_edited_by
ndb_last_edited_time
ndb_multi_select
ndb_number
ndb_people
ndb_phone_number
ndb_relation
ndb_rollup
ndb_nameProperty
ndb_select
ndb_status
ndb_title
ndb_textProperty
ndb_text
ndb_rich_text
ndb_url
"@
$b = $a.split("`n")

$j = 1
$b | ForEach-Object {
    #$i=$_|out-string
    # [string]$fn = $j:2 + "_" + $i
    #$fn = "$fn.ps1`n"
    #$i.GetType()
    [string] $filename = "{0:D2}_{1}" -f $j, $_
    [string]$fn = $filename# + ".ps1"
    # write-output ('"' + $fn + '"')
    $fn
    $j++
}
