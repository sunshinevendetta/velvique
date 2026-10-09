param(
  [string]$Image,
  [string]$Out = "model.glb",
  [int]$Seed = 0,
  [ValidateSet("glb","stl")][string]$Format = "glb",
  [switch]$NoTexture
)

$ErrorActionPreference = "Stop"

# Folder where this script lives
$root = $PSScriptRoot
if (-not $root) { $root = (Get-Location).Path }

if (-not $env:NVIDIA_API_KEY) {
  throw "Set your key first:  `$env:NVIDIA_API_KEY = 'nvapi-xxxx'"
}

# Find the image in the script's folder
if ($Image) {
  if ([IO.Path]::IsPathRooted($Image)) { $fullPath = $Image }
  else { $fullPath = Join-Path $root $Image }
}
else {
  $found = Get-ChildItem -Path $root -File |
           Where-Object { $_.Extension -match '^\.(png|jpg|jpeg|webp)$' } |
           Select-Object -First 1
  if (-not $found) { throw "No png/jpg/jpeg/webp found in $root" }
  $fullPath = $found.FullName
}

if (-not (Test-Path $fullPath)) {
  throw "Image not found: $fullPath"
}

# Encode the image as a data URI
$bytes = [IO.File]::ReadAllBytes($fullPath)
$ext   = [IO.Path]::GetExtension($fullPath).TrimStart('.').ToLower()
if ($ext -eq "jpg") { $ext = "jpeg" }
$dataUri = "data:image/$ext;base64," + [Convert]::ToBase64String($bytes)

$headers = @{
  Authorization = "Bearer $env:NVIDIA_API_KEY"
  Accept        = "application/json"
}

$body = @{
  mode                = "image"
  image               = $dataUri
  output_format       = $Format
  no_texture          = [bool]$NoTexture
  samples             = 1
  seed                = $Seed
  ss_cfg_scale        = 7.5
  slat_cfg_scale      = 3
  ss_sampling_steps   = 25
  slat_sampling_steps = 25
} | ConvertTo-Json

Write-Host "Sending $fullPath ..."
try {
  $r = Invoke-WebRequest -Uri "https://ai.api.nvidia.com/v1/genai/microsoft/trellis" `
         -Method Post -Headers $headers -Body $body `
         -ContentType "application/json" -UseBasicParsing
}
catch {
  $resp = $_.Exception.Response
  if ($resp) {
    $reader = New-Object IO.StreamReader($resp.GetResponseStream())
    $errText = $reader.ReadToEnd()
    Write-Host "HTTP $([int]$resp.StatusCode): $errText"
  }
  throw
}

# If the job is queued, poll until it finishes
while ($r.StatusCode -eq 202) {
  $id = [string]($r.Headers["NVCF-REQID"] | Select-Object -First 1)
  Write-Host "Queued ($id), waiting..."
  Start-Sleep -Seconds 5
  $r = Invoke-WebRequest -Uri "https://api.nvcf.nvidia.com/v2/nvcf/pexec/status/$id" `
         -Headers $headers -UseBasicParsing
}

# Pull the base64 payload with a regex (ConvertFrom-Json chokes on big strings in Windows PowerShell 5.1)
$m = [regex]::Match($r.Content, '"base64"\s*:\s*"([^"]+)"')
if (-not $m.Success) {
  $r.Content | Set-Content -Path (Join-Path $root "response.json")
  throw "No base64 field found. Raw response saved to $root\response.json"
}

$outPath = Join-Path $root $Out
[IO.File]::WriteAllBytes($outPath, [Convert]::FromBase64String($m.Groups[1].Value))
Write-Host "Saved $outPath"