function Get-CrwdSandboxReport {
    <#
        .SYNOPSIS
            This function will pull the Counter Adversary Operations Sandbox report by report ID.
        .PARAMETER token
            This parameter is mandatory. This is an OAuth2 token that should be previously generated from your CrowdStrike secret.
        .PARAMETER reportId
            This parameter is mandatory. Id used to look up the Sandbox report. Usually 65 characters with an underscore in the middle.
            Can be obtained useing the New-CrwdUrlSubmission function.
        .Example
            PS> $verdict = (Get-CrwdSandboxReport -token $token -reportId $reportId).resources.verdict

            PS> $siteContactedHosts = (Get-CrwdSandboxReport -token $token -reportId $reportId).resources.sandbox.contacted_hosts

    #>
    
    param (
        [Parameter(Mandatory=$true)]
        [string]$token,
    
        [Parameter(Mandatory=$true)]
        [string]$reportId
    )

    $uri = 'https://api.crowdstrike.com/falconx/entities/reports/v1?ids={0}' -f $reportId
    $headers = @{
        "accept" = "application/json"
        "authorization" = "Bearer $token"
    }
    $response = Invoke-RestMethod -Uri $uri -Headers $headers

    return $response

    <# CURL: Get Sandbox Report

        curl -X GET \
        "https://api.crowdstrike.com/falconx/entities/reports/v1?ids=$reportId" \
        -H "accept: application/json" \
        -H "authorization: Bearer $token"
    #>
}