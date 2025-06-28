function Get-SDCProductInfo {
    <#
    .SYNOPSIS
        Retrieves a list of products.

    .DESCRIPTION
        This function fetches a list of products from the endoflife.date API and returns it as a PowerShell object.
        Uses either the /products/{productName} endpoint to retrieve specific product information or the /products/{productName}/releases/latest endpoint to get the latest release information.

    .EXAMPLE
        Get-SDCProductList

    .NOTES
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$ProductName,

        [switch]$Latest
    )

    if ($Latest) {
        $url = "https://endoflife.date/api/v1/products/$($ProductName)/releases/latest"
    }
    else {
        $url = "https://endoflife.date/api/v1/products/$($ProductName)"
    }

    try {
        $product = Invoke-RestMethod -Uri $url -ErrorAction Stop
    }
    catch {
        Write-Error "Failed to retrieve product information for '$ProductName'. Error: $_"
        return
    }
    if ($null -eq $product) {
        Write-Error "No product found with the name '$ProductName'."
        return
    }

    Write-Verbose "Product information for '$ProductName' retrieved successfully."
    return $product.result

}
