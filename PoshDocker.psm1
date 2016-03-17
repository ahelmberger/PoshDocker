function exists($tool) {
  Write-Host "Searching for $tool ..."
  $cmd = gcm $tool -ErrorAction SilentlyContinue
  if ($cmd -ne $Null) {
    Write-Host "Found $($cmd.Path)" -ForegroundColor Green
    return $True
  } else {
    Write-Host "$tool could not be found" -ForegroundColor Red
    return $False
  }
}

function Start-Boot2Docker {
  if ((exists boot2docker) -and (exists docker) -and (exists ssh)) {
    Write-Host "Starting boot2docker ..." -ForegroundColor Yellow
    & boot2docker start
    Write-Host "Setting environment variables ..." -ForegroundColor Yellow
    & boot2docker shellinit | % { $_ -replace "^\s*set\s+(DOCKER_[A-Z_]+)\s*=\s*(.*)\s*$", "`$Env:`$1 = '`$2'" } | iex
    & boot2docker ip | % { Write-Host "Docker host is running on IP $_" -ForegroundColor Green }
  }
}

function Stop-Boot2Docker {
  if (exists boot2docker) {
    Write-Host "Stopping boot2docker ..." -ForegroundColor Yellow
    & boot2docker stop
  }
}

Export-ModuleMember -Function Start-Boot2Docker, Stop-Boot2Docker
