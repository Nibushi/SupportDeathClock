function Get-SDCAllProductInfo {
    <#
    .SYNOPSIS
        Retrieves a list of all products.

    .DESCRIPTION
        This function fetches a list of all products from the endoflife.date API and returns it as a PowerShell object.

    .EXAMPLE
       Get-SDCAllProductInfo

    .NOTES
    #>
    [CmdletBinding()]
    param(
    )

    $url = "https://endoflife.date/api/v1/products/full"
    try {
        $products = Invoke-RestMethod -Uri $url -ErrorAction Stop
    }
    catch {
        Write-Error "Failed to retrieve all product information. Error: $_"
        return
    }
    if ($null -eq $products) {
        Write-Error "No productS found."
        return
    }

    Write-Verbose "All Product information retrieved successfully."
    return $products
}
