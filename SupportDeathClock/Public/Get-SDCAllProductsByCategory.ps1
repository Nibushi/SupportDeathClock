function Get-SDCAllProductsByCategory {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Category
    )

    $url = "https://endoflife.date/api/v1/categories/$($Category)"

    try {
        $products = Invoke-RestMethod -Uri $url -ErrorAction Stop
    }
    catch {
        Write-Error "Failed to retrieve product information for category '$Category'. Error: $_"
        return
    }

    if ($null -eq $products) {
        Write-Error "No products found in the name '$Category'."
        return
    }

    Write-Verbose "Product information for category '$Category' retrieved successfully."
    return $products.result
}
