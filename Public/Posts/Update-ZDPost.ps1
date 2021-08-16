<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function Update-ZDPost
{
    [CmdletBinding()]
    [Alias()]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true
                   )]
        $PostObject,

        # Param2 help description
        [Parameter(Mandatory=$true)]
        $PostID
    )

    Begin
    {
        Write-Verbose -Message 'Creating parameters from Update-ZDPost'

        $params = @{
            Uri = "https://$env:ZDDomain.zendesk.com/api/v2/community/posts/$PostID"
            Method = 'Put'
            Body = $($PostObject | ConvertTo-Json -Depth 10)
            Headers = $ZDHeaders
            ContentType = 'application/json'
        }
    }
    Process
    {
        Write-Verbose -Message 'Invoking Rest Method from Update-ZDPost'

        $Result = Invoke-RestMethod @params
    }
    End
    {
        Write-Verbose -Message 'Returning results from Update-ZDPost'

        return $Result
    }
}