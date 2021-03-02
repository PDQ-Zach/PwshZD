﻿<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function Get-ZDAllTickets {
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory = $false,
            ValueFromPipelineByPropertyName = $true,
            Position = 0)]
        $OrgID,

        # Param2 help description
        $UserID,

        [Parameter(ParameterSetName = 'User')]
        [switch]$Requested,
        [Parameter(ParameterSetName = 'User')]
        [switch]$CCD,
        [Parameter(ParameterSetName = 'User')]
        [switch]$Assigned


    )

    Begin {
        Write-Verbose -Message 'Creating parameters from Get-ZDAllTickets'

        $Tickets = [Collections.arraylist]::new()

        if ($OrgID) {
            $URI = "https://$env:ZDDomain.zendesk.com/api/v2/organizations/$OrgID/tickets.json"
        }

        if ($UserID) {
            switch ($PSBoundParameters.Keys) {
                'Requested' { $URI = "https://$env:ZDDomain.zendesk.com/api/v2/users/$UserID/tickets/requested.json" }
                'CCD' { $URI = "https://$env:ZDDomain.zendesk.com/api/v2/users/$UserID/tickets/ccd.json" }
                'Assigned' { $URI = "https://$env:ZDDomain.zendesk.com/api/v2/users/$UserID/tickets/assigned.json" }
            }
        }

        if (($null -eq $UserID) -or ($null -eq $OrgID)) {
            $URI = "https://$env:ZDDomain.zendesk.com/api/v2/tickets.json"
        }

        #Get the number of pages returned
        $params = @{
            Uri     = $URI
            Method  = 'Get'
            Headers = $ZDHeaders
        }

        $Pages = Get-Pages -URI $URI  
    }

    Process
    {
        Write-Verbose -Message 'Invoking Rest Method from Get-ZDAllTickets'

        Foreach ($page in $Pages) {
        
            $params = @{
                Uri     = $page
                Method  = 'Get'
                Headers = $ZDHeaders
                ContentType =  "Application/JSON"
            }

            $Tickets += (Invoke-RestMethod  @params).tickets
        }
    }
    End
    {
        return $Tickets
    }
}
