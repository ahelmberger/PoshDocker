function Install-PoshDocker {
    $ModulePaths = @($env:PSModulePath -split ';')
    $ExpectedUserModulePath = Join-Path -Path ([Environment]::GetFolderPath('MyDocuments')) -ChildPath WindowsPowerShell\Modules
    $Destination = $ModulePaths | Where-Object { $_ -eq $ExpectedUserModulePath }
    if (-not $Destination) {
        $Destination = $ModulePaths | Select-Object -Index 0
    }
    New-Item -Path ($Destination + "\PoshDocker\") -ItemType Directory -Force | Out-Null
    Write-Host 'Downloading PoshDocker from https://raw.githubusercontent.com/ahelmberger/PoshDocker/master/PoshDocker.psm1'
    $client = (New-Object Net.WebClient)
    $client.Proxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials
    $client.DownloadFile("https://raw.githubusercontent.com/ahelmberger/PoshDocker/master/PoshDocker.psm1", $Destination + "\PoshDocker\PoshDocker.psm1")

    $executionPolicy = (Get-ExecutionPolicy)
    $executionRestricted = ($executionPolicy -eq "Restricted")
    if ($executionRestricted) {
        Write-Warning @"
Your execution policy is $executionPolicy, this means you will not be able import or use any scripts including modules.
To fix this change your execution policy to something like RemoteSigned.

        PS> Set-ExecutionPolicy RemoteSigned

For more information execute:

        PS> Get-Help about_execution_policies

"@
    }

    if (!$executionRestricted) {
        # ensure PoshDocker is imported from the location it was just installed to
        Import-Module -Name $Destination\PoshDocker
    }
    Write-Host "PoshDocker is installed and ready to use" -Foreground Green
    Write-Host @"
USAGE:
    PS> Start-Boot2Docker
    PS> Stop-Boot2Docker

For more details visit https://github.com/ahelmberger/PoshDocker
"@
}

Install-PoshDocker
