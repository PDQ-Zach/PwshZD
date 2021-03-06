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
function Search-ZDTicketsByStatus
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    Param
    (
        [string]$Status
    )

    Begin
    {
        Write-Verbose -Message 'Creating parameters from Search-ZDTicketsByStatus'

        $Query = [URI]::EscapeDataString("status:$Status")
        
        $params = @{
            Uri = "https://$env:ZDDomain.zendesk.com/api/v2/search.json?query=$Query"
            Method = 'Get'
            Headers = $ZDHeaders
        }
       
    }
    Process
    {
        Write-Verbose -Message 'Invoking Rest Method from Search-ZDTicketsByStatus'

        $Result = Invoke-RestMethod @params
    }
    End
    {
        Write-Verbose -Message 'Returning results from Search-ZDTicketsByStatus'

        Add-ObjectDetail -InputObject $Result.results -TypeName PwshZD.Fields -DefaultProperties id,subject,status,requester_id,created_at
    }
}