$acProductName = {
    # Although it is called ProductName, it is actually the product label
    # The label property contains more information than just the product name, so we will use it to complete the parameter
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)

    $wordToComplete = $wordToComplete.trim("'")

    $url = "https://endoflife.date/api/v1/products"

    $products = Invoke-RestMethod -Uri $url
    $productNames = $products.result.name | Sort-Object

    $productNames | Where-Object { $_ -like "$wordToComplete*" } | ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
    }
}

# Register argument completer to specific command and (non-standard) parameters
Register-ArgumentCompleter -CommandName "Get-SDCProductInfo" -ParameterName "ProductName" -ScriptBlock $acProductName

# Auto Register argument completers to standard parameters in module
# $module = $MyInvocation.MyCommand.Module
# $commands = Get-Command -Module $module

# Write-Host "Registering argument completers for commands in module ' $($MyInvocation.MyCommand.Module)'..."

#  foreach ($command in $commands) {
#     # if ($command.Parameters.ContainsKey('ProductName')) {
#     #     # $splat = @{
#     #     #     CommandName = $command.Name
#     #     #     ParameterName = 'ProductName'
#     #     #     ScriptBlock = $acProductName
#     #     # }

#     #     # Register-ArgumentCompleter @splat
#     # }
#}
