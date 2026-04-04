$root    = $PSScriptRoot
$wowBase = "C:\Games\World of Warcraft\_retail_\Interface\AddOns"

$addons = @(
    @{
        Name    = "LibMythicKeystone"
        Exclude = @("README.md", "DEVELOPERS.md", ".pkgmeta")
    },
    @{
        Name    = "MythicKeystone"
        Exclude = @("README.md", ".pkgmeta")
    },
    @{
        Name    = "MythicKeystone_LibDataBroker"
        Exclude = @("README.md", ".pkgmeta")
    }
)

$hasError = $false

foreach ($addon in $addons) {
    $source = Join-Path $root $addon.Name
    $dest   = Join-Path $wowBase $addon.Name

    Write-Host "Deploying $($addon.Name)..." -ForegroundColor Cyan
    Write-Host "  From : $source"
    Write-Host "  To   : $dest"
    Write-Host ""

    robocopy $source $dest /E /NJH /NJS `
        /XD ".git" ".github" ".vscode" `
        /XF ($addon.Exclude -join " ")

    if ($LASTEXITCODE -le 7) {
        Write-Host "Done." -ForegroundColor Green
    } else {
        Write-Host "Robocopy error (code $LASTEXITCODE)." -ForegroundColor Red
        $hasError = $true
    }
    Write-Host ""
}

if ($hasError) { exit 1 }
