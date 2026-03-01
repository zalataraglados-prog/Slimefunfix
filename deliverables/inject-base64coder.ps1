param(
    [Parameter(Mandatory = $true)]
    [string]$JarPath
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path $JarPath)) {
    throw "Jar not found: $JarPath"
}

$classPath = "org/yaml/snakeyaml/external/biz/base64Coder/Base64Coder.class"
if (-not (Test-Path $classPath)) {
    throw "Class file not found: $classPath"
}

Write-Host "[1/2] Injecting Base64Coder.class into $JarPath"
jar uf $JarPath $classPath

Write-Host "[2/2] Verifying jar contains class"
$entry = jar tf $JarPath | Select-String -SimpleMatch $classPath
if (-not $entry) {
    throw "Injection failed: class entry not found in jar"
}

Write-Host "Done. Injection successful."
