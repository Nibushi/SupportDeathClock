function Format-ProductResultAsObject{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$ProductName,

        [Parameter(Mandatory = $true)]
        [object]$ProductResult
    )

    $relObj = [PSCustomObject]@{
        ProductName = $ProductName
        prodRelease = $ProductResult.name
        prodReleased = $ProductResult.prodreleaseDate
        OutOfActiveSupport = $ProductResult.isEoas
        ActiveSupportEnds = $ProductResult.eoasFrom
        EndOfLife = $ProductResult.isEol
        SecuritySupportEnds = $ProductResult.eolFrom
        Maintained = $ProductResult.isMaintained
        LatestBuild = $ProductResult.latest.name
        LatestBuildprodReleaseDate = $ProductResult.latest.date
        LatestBuildUrl = $ProductResult.latest.link
        IsLts = $ProductResult.isLts
        LtsFromDate = $ProductResult.ltsFrom
    }

    $relObj
}
