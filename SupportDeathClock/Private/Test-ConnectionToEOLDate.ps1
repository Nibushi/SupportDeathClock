function Test-ConnectionToEOLDate {
    [CmdletBinding()]
    param()

    # Write code which will use Invoke-WebRequest to check if the endoflife.date API is reachable
    $url = "https://endoflife.date/api/v1"
    try {
        $response = Invoke-WebRequest -Uri $url -UseBasicParsing -ErrorAction Stop
        if ($response.StatusCode -eq 200) {
            Write-Verbose "Connection to endoflife.date API is successful."
            return $true
        } else {
            Write-Error "Failed to connect to endoflife.date API. Status code: $($response.StatusCode)"
            return $false
        }
    } catch {
        Write-Error "Error connecting to endoflife.date API: $_"
        return $false
    }
}
