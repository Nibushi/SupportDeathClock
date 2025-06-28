function Get-SDCAllProductsByTag {
    <#
    .SYNOPSIS
        Retrieves all products associated with a specific tag from the endoflife.date API.

    .DESCRIPTION
        The Get-SDCAllProductsByTag function queries the endoflife.date API to retrieve
        all products that are associated with a specific tag. This function helps identify
        software products that share common characteristics or categories.

    .PARAMETER Tag
        The tag name to search for in the endoflife.date database. This parameter is mandatory.

    .EXAMPLE
        Get-SDCAllProductsByTag -Tag "Microsoft"

        Retrieves all Microsoft products from the endoflife.date API.

    .EXAMPLE
        Get-SDCAllProductsByTag -Tag "Database" -Verbose

        Retrieves all database-related products with verbose output displaying the retrieval status.

    .OUTPUTS
        System.Object
        Returns an array of product objects associated with the specified tag.

    .NOTES
        This function requires internet connectivity to access the endoflife.date API.
        API endpoint: https://endoflife.date/api/v1/tags/{tag}

    .LINK
        https://endoflife.date/docs/api

    .LINK
        https://endoflife.date/api/v1/tags
    #>

    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$Tag
    )

    $url = "https://endoflife.date/api/v1/tags/$($Tag)"

    try {
        $products = Invoke-RestMethod -Uri $url -ErrorAction Stop
    }
    catch {
        Write-Error "Failed to retrieve product information for tag '$Tag'. Error: $_"
        return
    }

    if ($null -eq $products) {
        Write-Error "No products found for the tag '$Tag'."
        return
    }

    Write-Verbose "Product information for tag '$Tag' retrieved successfully."
    return $products.result
}
