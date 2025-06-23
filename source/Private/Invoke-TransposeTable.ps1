function Invoke-TransposeTable {
    param([array]$matrix)

    $rowCount = $matrix.Count
    $colCount = ($matrix | Select-Object -First 1).Count

    for ($i = 0; $i -lt $colCount; $i++) {
        $row = for ($j = 0; $j -lt $rowCount; $j++) {
            $matrix[$j][$i]
        }
        ,$row
    }
}
