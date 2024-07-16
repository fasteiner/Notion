class ndb_date {
    $type = "date"
    $date
    ndb_date($date) {
        $this.date = [ndb_dateProperty]::new($date)
    }
}
