param(
  [Parameter(Mandatory = $false, Position = 0, ValueFromRemainingArguments,
    HelpMessage = "Enter one or more specific tests")]
  [string[]]
  $Test
)

function Undo-Location {
  Pop-Location
  Write-Output "Change directory back to: $(Get-Location)"
}

Write-Output "`n==> Start running tests at $(Get-Date)"

$scriptPath = Split-Path -Path $PSCommandPath -Parent
$basePath = Split-Path -Path $scriptPath -Parent
Push-Location "$basePath"
Write-Output "Change directory to: $basePath"

& "$scriptPath\bin\checkScripts.ps1"
Write-Output "`n==> PowerShell script analysis finished at $(Get-Date)"
if ($LastExitCode) {
  Undo-Location
  Write-Output "`ncheckScripts failed with exit code: $LastExitCode"
  Exit $LastExitCode
}

# Do not run Node tests during CI as will already have been run in the bash script
if ([System.Environment]::GetEnvironmentVariable("CI") -ne "true") {
  Write-Output "`n==> Start running Node tests at $(Get-Date)"
  if ($PSBoundParameters.ContainsKey('Test')) {
    npm run test-all $Test
  } else {
    npm run test-all
  }
  if ($LastExitCode) {
    Undo-Location
    Write-Output "`nNode tests failed with exit code: $LastExitCode"
    Exit $LastExitCode
  }
}

Undo-Location
Write-Output "`n==> Tests finished at $(Get-Date)`n"
