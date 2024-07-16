class ndb_phone_number {
    $type = "phone_number"
    [string] $phone_number

    ndb_phone_number($phone_number) {
        $this.phone_number = $phone_number
    }
}
