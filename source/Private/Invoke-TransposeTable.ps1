function Invoke-TransposeTable {
    <#
    .SYNOPSIS
        Transposes a two-dimensional array (matrix).

    .DESCRIPTION
        Takes a two-dimensional array (matrix) and returns a new array where the rows and columns are swapped.

    .PARAMETER matrix
        The two-dimensional array to transpose. Each element should itself be an array representing a row.

    .OUTPUTS
        array
        Returns a transposed two-dimensional array.

    .EXAMPLE
        $matrix = @( @(1, 2, 3), @(4, 5, 6) )
        $transposed = Invoke-TransposeTable -matrix $matrix
        # $transposed is @( @(1, 4), @(2, 5), @(3, 6) )

    .NOTES
        Useful for converting between row-major and column-major representations of tabular data.
    #>
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [Alias("InputObject")]
        [array]$matrix
        )

    $rowCount = $matrix.Count
    $colCount = ($matrix | Select-Object -First 1).Count

    $result = @()
    for ($i = 0; $i -lt $colCount; $i++) {
        $row = for ($j = 0; $j -lt $rowCount; $j++) {
            $matrix[$j][$i]
        }
        $result += ,$row
    }
    return $result
}
