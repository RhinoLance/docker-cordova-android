#check if docker engine is running
try {
	docker info | Out-Null
}
catch {
	Write-Host "Docker engine is not running. Please start Docker and try again."
	exit 1
}

$buildEnvPath = Join-Path $PSScriptRoot 'build.env'
if (-not (Test-Path $buildEnvPath)) {
    Write-Host "Could not find build env file at $buildEnvPath"
    exit 1
}

$envValues = @{}
Get-Content $buildEnvPath | ForEach-Object {
    $line = $_.Trim()

    if ([string]::IsNullOrWhiteSpace($line) -or $line.StartsWith('#')) {
        return
    }

    $parts = $line -split '=', 2
    if ($parts.Count -ne 2) {
        return
    }

    $key = $parts[0].Trim()
    $value = $parts[1].Trim()

    if (-not [string]::IsNullOrWhiteSpace($key)) {
        $envValues[$key] = $value
    }
}

$dockerArgs = @()
foreach ($entry in $envValues.GetEnumerator()) {
    $dockerArgs += '--build-arg'
    $dockerArgs += "$($entry.Key)=$($entry.Value)"
}

Push-Location (Resolve-Path (Join-Path $PSScriptRoot '..'))
try {
    
	# run the build command and tee the output to a log file
    & docker build . `
		--progress=plain `
		-t 'cordova-android:dev' `
		@dockerArgs `
		*>&1 `
		| Tee-Object -FilePath 'docker-build.log'
        

    exit $LASTEXITCODE
}
finally {
    Pop-Location
}
