<#
.Synopsis
   Searches Zendesk tickets by subject
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function Search-ZDTicketsBySubject
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    Param
    (
        [string]$Subject,
        $Created_After
    )

    Begin
    {
        Write-Verbose -Message 'Creating parameters from Search-ZDTicketsBySubject'

        If ([bool]($MyInvocation.BoundParameters.Keys -match 'Created_After')){
            Query = [URI]::EscapeDataString("subject:$Subject Created>$created_after")
        }
        else{
            $Query = [URI]::EscapeDataString("subject:$Subject")
        }
        
        
        $params = @{
            Uri = "https://$env:ZDDomain.zendesk.com/api/v2/search.json?query=$Query"
            Method = 'Get'
            Headers = $ZDHeaders
        }
       
    }
    Process
    {
        Write-Verbose -Message 'Invoking Rest Method from Search-ZDTicketsBySubject'

        $Result = Invoke-RestMethod @params
    }
    End
    {
        Write-Verbose -Message 'Returning results from Search-ZDTicketsBySubject'

        Add-ObjectDetail -InputObject $Result.results -TypeName PwshZD.Fields -DefaultProperties id,subject,Subject,requester_id,created_at
    }
}