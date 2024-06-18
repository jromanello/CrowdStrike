function New-CrwdUrlSubmission {
    <#
        .SYNOPSIS
            This function submits a URL to CrowdStrike Falcon --> Counter Adversary Operations --> Sandbox. Typical analysis time is <15 minutes.
        .PARAMETER token
            This parameter is mandatory. This is an OAuth2 token that should be previously generated from your CrowdStrike secret.
        .PARAMETER url
            This parameter is mandatory. The URL you'd like to submit for analysis.
        .EXAMPLE
            PS> New-CrwdUrlSubmission -token <your_OAuth2_token> -url https://sketchy-site.com
        
            PS> $reportId = (New-CrwdUrlSubmission -token <your_OAuth2_token> -url https://sketchy-site.com).resources.id
    #>

    param (
        [Parameter(Mandatory=$true)]
        [string]$token,

        [parameter(Mandatory=$true)]
        [string]$url
    )

    # Submit URL for Analysis
    $headers = @{
        'Authorization' = "bearer $token"
        'Content-Type' = 'application/json'
    }
    $uri = 'https://api.crowdstrike.com/falconx/entities/submissions/v1'
    $body = @{
        "sandbox" = @(
            @{
                "environment_id" = 160
                "url" = "$url"
            }
        )
    } | ConvertTo-Json

    $response = Invoke-RestMethod -Uri $uri -Headers $headers -Method Post -Body $body

    return $response

    <#  CURL: How to submit URL for analysis

        curl -X POST "https://api.crowdstrike.com/falconx/entities/submissions/v1" \
            -H "accept: application/json" \
            -H "authorization: Bearer $token" \
            -H "Content-Type: application/json" \
            -d '{
                "sandbox": [
                    {
                        "environment_id": 160,
                        "url": "https://www.advancedscoreboard.com"
                    }
                ]
            }'
    #>
}