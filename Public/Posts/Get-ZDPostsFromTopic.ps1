<#
.Synopsis
   Gets Zendesk community posts by ID
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function Get-ZDPostsFromTopic
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$TopicID
    )

    Begin
    {
        Write-Verbose -Message 'Creating parameters from Get-ZDPost'
        $Uri = "https://$env:ZDDomain.zendesk.com/api/v2/community/topics/$TopicID/posts.json" 
        $ReturnObject = [Collections.Arraylist]::new() 
    }
    Process
    {
        Write-Verbose -Message 'Invoking Rest Method from Get-ZDPost'

        foreach ($page in (Get-Pages -URI $URI)){
            $params = @{
                Uri = $page
                Method = 'Get'
                Headers = $ZDHeaders
            }
            $ReturnObject += (Invoke-RestMethod @params).Posts
        }
    }
    End
    {
        return $ReturnObject
    }
}