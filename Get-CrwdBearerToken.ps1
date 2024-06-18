function Get-CrwdBearerToken {
    <#
        .SYNOPSIS
            This function uses a CrowdStrike secret to generate a authorization token for API use.
        .PARAMETER clientId
            This parameter is mandatory. Your CrowdStrike client ID.
        .PARAMETER secret
            This parameter is mandatory. Your CrowdStrike secret.
        .EXAMPLE
            PS> $token = Get-CrwdBearerToken -clientId <your_clientId> -secret <your_secret>
    #>
    
    param (
        [Parameter(Mandatory=$true)]
        [string]$clientId,

        [Parameter(Mandatory=$true)]
        [string]$secret
    )

    # Get bearer token (OAuth2)
    $uri = 'https://api.crowdstrike.com/oauth2/token'
    $body = @{
        client_id = $clientId
        client_secret = $secret
    }
    $headers = @{
        "Accept"="application/json"
    }
    $response = Invoke-RestMethod -Uri $uri -Method Post -Body $body -ContentType "application/x-www-form-urlencoded" -Headers $headers
    
    # Return token
    return $response.access_token

    <#  CURL: How to get bearer token
        
    $token = curl -X POST "https://api.crowdstrike.com/oauth2/token" \
        -H "accept: application/json" \
        -H "Content-Type: application/x-www-form-urlencoded" \
        -d "client_id=$clientId&client_secret=$key"
    #>
}