function Add-ArgumentCompleters{
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

    $acCategory = {
        param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)

        $wordToComplete = $wordToComplete.trim("'")

        $url = "https://endoflife.date/api/v1/categories"

        $categories = Invoke-RestMethod -Uri $url
        $categoryNames = $categories.result.name | Sort-Object

        $categoryNames | Where-Object { $_ -like "$wordToComplete*" } | ForEach-Object {
            [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
        }
    }

    $acTags = {
        param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)

        $wordToComplete = $wordToComplete.trim("'")

        $url = "https://endoflife.date/api/v1/tags"

        $tags = Invoke-RestMethod -Uri $url
        $tagNames = $tags.result.name | Sort-Object

        $tagNames | Where-Object { $_ -like "$wordToComplete*" } | ForEach-Object {
            [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
        }
    }

    $acRelease = {
        param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)

        $wordToComplete = $wordToComplete.trim("'")

        if($fakeBoundParameters.ContainsKey('ProductName')){
            $productName = $fakeBoundParameters['ProductName']
            $url = "https://endoflife.date/api/v1/products/$($productName)"

            $product = Invoke-RestMethod -Uri $url
            $releaseNames = $product.result.releases.name

            $releaseNames | Where-Object { $_ -like "$wordToComplete*" } | ForEach-Object {
                [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
            }
        }
    }


    # Register argument completer to specific command and (non-standard) parameters
    #Register-ArgumentCompleter -CommandName "Get-SDCProductInfo" -ParameterName "ProductName" -ScriptBlock $acProductName

    # Auto Register argument completers to standard parameters in module

    $module = $MyInvocation.MyCommand.Module
    $commands = Get-Command -Module $module

    foreach ($command in $commands) {
        if ($command.Parameters.ContainsKey('ProductName')) {
            $splat = @{
                CommandName = $command.Name
                ParameterName = 'ProductName'
                ScriptBlock = $acProductName
            }

            Register-ArgumentCompleter @splat
        }

        if ($command.Parameters.ContainsKey('Category')) {
            $splat = @{
                CommandName = $command.Name
                ParameterName = 'Category'
                ScriptBlock = $acCategory
            }

            Register-ArgumentCompleter @splat
        }

        if ($command.Parameters.ContainsKey('Tag')) {
            $splat = @{
                CommandName = $command.Name
                ParameterName = 'Tag'
                ScriptBlock = $acTags
            }

            Register-ArgumentCompleter @splat
        }

        if ($command.Parameters.ContainsKey('Release')) {
            $splat = @{
                CommandName = $command.Name
                ParameterName = 'Release'
                ScriptBlock = $acRelease
            }

            Register-ArgumentCompleter @splat
        }
    }
}
