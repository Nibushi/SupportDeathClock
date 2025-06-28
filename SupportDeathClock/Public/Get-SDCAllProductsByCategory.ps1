function Get-SDCAllProductsByCategory {
    <#
    .SYNOPSIS
        Retrieves all products for a specified category from the endoflife.date API.

    .DESCRIPTION
        The Get-SDCAllProductsByCategory function queries the endoflife.date API to retrieve
        all products that belong to a specific category. It returns the product information
        as objects that can be further processed.

    .PARAMETER Category
        The name of the category for which to retrieve products. This parameter is mandatory.

    .EXAMPLE
        PS> Get-SDCAllProductsByCategory -Category "operating-systems"

        Returns all products categorized as operating systems.

    .EXAMPLE
        PS> Get-SDCAllProductsByCategory -Category "databases" -Verbose

        Returns all database products with verbose output showing the retrieval progress.

    .OUTPUTS
        System.Object[]
        Returns an array of product objects from the specified category.

    .NOTES
        This function requires internet connectivity to access the endoflife.date API.
        If the API is unavailable or returns an error, an appropriate error message will be displayed.

    .LINK
        https://endoflife.date/docs/api/

    .LINK
        "https://endoflife.date/api/v1/categories/
    #>

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
