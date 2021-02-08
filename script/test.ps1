param(
  [Parameter(Mandatory = $false, Position = 0, ValueFromRemainingArguments,
    HelpMessage = "Enter one or more specific tests")]
  [string[]]
  $Test
)

$scriptPath = Split-Path -Path $PSCommandPath -Parent

Write-Output "`n==> Start running tests at $(Get-Date)"

if ($PSBoundParameters.ContainsKey('Test')) {
  & "$scriptPath\bin\checkScripts.ps1" $Test
} else {
  & "$scriptPath\bin\checkScripts.ps1"
}

Write-Output "`n==> PowerShell script analysis finished at $(Get-Date)"

if ($LastExitCode) {
  Write-Output "`ncheckScripts failed with exit code: $LastExitCode"
  Exit $LastExitCode
}

# Do not run Node tests during CI as will already have been run in the base script
if ([System.Environment]::GetEnvironmentVariable("CI") -ne "true") {
  Write-Output "`n==> Start running Node tests at $(Get-Date)"
  npm run test
  if ($LastExitCode) {
    Write-Output "`nNode tests failed with exit code: $LastExitCode"
    Exit $LastExitCode
  }
}

Write-Output "`n==> Tests finished at $(Get-Date)`n"
