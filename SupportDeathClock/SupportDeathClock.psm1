# Dot source public/private functions
$public = @(Get-ChildItem -Path (Join-Path -Path $PSScriptRoot -ChildPath 'Public\*.ps1')  -Recurse -ErrorAction Stop)
$private = @(Get-ChildItem -Path (Join-Path -Path $PSScriptRoot -ChildPath 'Private\*.ps1') -Recurse -ErrorAction Stop)

foreach ($import in @($public + $private)) {
    try {
        . $import.FullName
    }
    catch {
        throw "Unable to dot source [$($import.FullName)]"
    }
}

Export-ModuleMember -Function $public.Basename

# Check if the endoflife.date API is reachable
if (-not (Test-ConnectionToEOLDate)) {
    Write-Error "The endoflife.date API is not reachable. Please check your internet connection or the API status."
    return
}

# Register argument completers for the module
try {
    Add-ArgumentCompleters
}
catch {
    Write-Error "Failed to register argument completers: $_"
}
