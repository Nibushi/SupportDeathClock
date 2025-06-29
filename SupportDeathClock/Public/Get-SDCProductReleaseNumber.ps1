function Get-SDCProductReleaseNumber {

    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$ProductName
    )

    # Get product information to ensure the product exists
    $productInfo = @(Get-SDCProductInfo -ProductName $ProductName)

    # Create a generic list to hold release information
    $releaseInfo = [System.Collections.Generic.List[PSCustomObject]]::new()

    foreach($product in $productInfo){
        $releaseInfo.Add([PSCustomObject]@{
            Release = $product.prodRelease
        })
    }

    Write-Verbose "Release information for '$ProductName' retrieved successfully."
    return $releaseInfo
}
