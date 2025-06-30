# SupportDeathClock

A PowerShell module which uses the [endoflife.date](https://endoflife.date/) api to report on product support dates for different version of a product.

If it's not obvious, this is still under development 😊

## Installation

```powershell
Install-Module -Name SupportDeathClock
```

## Getting Started

The following are some examples of using the main commands

These cmdlets return a subset of the fields for each product. The fields include values, when available, for:

| Field Name   | Description |
| ----------   | ------------|
| ProductName  | Name of the product |
| prodRelease  | Version Number |
| prodReleased | Release date of Product version |
| OutOfActiveSupport | Whether the product version still receives active support, True or False |
| ActiveSupportEnds | Date on which active support will end |
| EndOfLife | Whether the product version is EOL, True or False |
| SecuritySupportEnds | End of Life date for product version |
| Maintained | Whether the product version still receives some level of support |
| LatestBuild | The latest build number of this product version |
| LatestBuildprodReleaseDate | Release date of the latest build of the current version |
| LatestBuildUrl | Link to the changelog or release notes |
| IsLts | Whether this product version still receives long term support |
| LtsFromDate | Start date of the LTS phase for this version of the product |

### Get-SDCAllProductInfo

This command uses the [https://endoflife.date/api/v1/products/full](https://endoflife.date/docs/api/v1/#/Products/products_full) end point and returns a list of all the products maintained in the endoflife.date data, including all releases. To reduce the amount of data transferred it is preferable to use `Get-SDCAllProductInfo`.

```powershell
Get-SDCAllProductInfo
```

### Get-SDCProductInfo

This command can be in the following ways

```powershell
# This will return information regarding all versions of a product, in this case python
# ProductName uses an ArgumentCompleter, so you will be able to use tab completion to see all the possible product names
Get-SDCProductInfo -ProductName python

```

```powershell
# This will return information regarding a specific versions of a product, in this case python version 3.5
# Release uses an ArgumentCompleter, so you will be able to use tab completion to see all the possible versions of the product
Get-SDCProductInfo -ProductName python -Release 3.5
```

```powershell
# This will return information regarding the latest versions of a product, in this case python.
Get-SDCProductInfo -ProductName python -Latest
```

### Get-SDCAllProductsByCategory

The endpoint only returns a limited set of data regarding each products. Useful for seeing which products are supported without having to return all the products. Categories include:

- app
- database
- device
- framework
- lang
- os
- server-app
- service
- standard

```powershell
# Returns a list of all the products available for a specific category
# Category uses an ArgumentCompleter, so you will be able to use tab completion to see all possible categories
Get-SDCAllProductsByCategory -Category os

name     : windows
aliases  : {}
label    : Microsoft Windows
category : os
tags     : {microsoft, os, windows}
uri      : https://endoflife.date/api/v1/products/windows
```

### Get-SDCAllProductsByTag

Similar to the `Get-SDCAllProductsByCategory` cmdlet. The endpoint only returns a limited set of data regarding each products.

```powershell
# Returns a list of all the products available for a specific tag
# Tag uses an ArgumentCompleter, so you will be able to use tab completion to see all possible Tags
Get-SDCAllProductsByTag -Tag microsoft

name     : windows
aliases  : {}
label    : Microsoft Windows
category : os
tags     : {microsoft, os, windows}
uri      : https://endoflife.date/api/v1/products/windows
```

### Get-SDCProductReleaseNumber

Returns a list of all available Releases for a product

```powershell
# ProductName uses an ArgumentCompleter, so you will be able to use tab completion to see all the possible product names
Get-SDCProductReleaseNumber -ProductName flux

Release
-------
2.6
2.5
2.4
2.3
2.2
2.1
2.0
1.25

```
