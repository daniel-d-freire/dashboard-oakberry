# sobe-mes.ps1
# Uso: .\sobe-mes.ps1
# Copia o index.html mais recente da pasta Downloads e faz o deploy

$GIT      = "C:\Program Files\Git\cmd\git.exe"
$REPO     = "C:\Users\User\oakberry-produtos"
$DOWNLOAD = "$env:USERPROFILE\Downloads"

# Pega o arquivo mais recente com nome oakberry-produtos*
$src = Get-ChildItem "$DOWNLOAD\oakberry-produtos*.html" | Sort-Object LastWriteTime -Descending | Select-Object -First 1

if (-not $src) {
    Write-Host "ERRO: Nenhum arquivo oakberry-produtos*.html encontrado em Downloads." -ForegroundColor Red
    exit 1
}

Write-Host "==> Usando: $($src.Name)" -ForegroundColor Cyan
Copy-Item $src.FullName "$REPO\index.html" -Force

Set-Location $REPO
& $GIT add -A

$STATUS = & $GIT status --porcelain
if (-not $STATUS) {
    Write-Host "==> Sem alteracoes para publicar." -ForegroundColor Yellow
    exit 0
}

$TIMESTAMP = Get-Date -Format "yyyy-MM-dd HH:mm"
& $GIT commit -m "update: $TIMESTAMP"
& $GIT push origin main
if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "==> ERRO NO PUSH! Commit foi feito, mas nao subiu para o GitHub." -ForegroundColor Red
    Write-Host "    Rode novamente: .\sobe-mes.ps1  (ou: git push origin main)" -ForegroundColor Yellow
    exit 1
}

Write-Host ""
Write-Host "==> Publicado!" -ForegroundColor Green
Write-Host "    https://dashboard-oakberry.vercel.app" -ForegroundColor Cyan
