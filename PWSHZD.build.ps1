task InstallDependancies {
    $Modules = @(
            "PSScriptAnalyzer"
            "Pester"
          )
          Install-Module -Name $Modules -Scope "CurrentUser" -Force -ErrorAction "Stop"
          Write-Output "Installed $($Modules -join ',')"
}

task Build {
    $Modules = @(
        "InvokeBuild"
        "PSScriptAnalyzer"
        "Pester"
      )
      Import-Module -Name $Modules -ErrorAction "Stop"
      Write-Output "Imported $($Modules -join ',') into the session"
}

task Analyze{
    Write-Output "This is the Analyze stage"
}

task Test {
    Write-Output "This is the test stage"
}