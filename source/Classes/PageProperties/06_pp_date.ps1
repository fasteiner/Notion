class pp_date {
    $type = "date"
    $date
    pp_date($date) {
        $this.date = [pp_dateProperty]::new($date)
    }
}
