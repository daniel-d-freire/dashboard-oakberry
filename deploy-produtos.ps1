# deploy-produtos.ps1
# Publica o dashboard Oakberry Produtos no GitHub/Vercel
# Uso: .\deploy-produtos.ps1

$GIT  = "C:\Program Files\Git\cmd\git.exe"
$REPO = "C:\Users\User\oakberry-produtos"

Set-Location $REPO

Write-Host "==> Verificando alteracoes..." -ForegroundColor Cyan
$STATUS = & $GIT status --porcelain

if (-not $STATUS) {
    Write-Host "==> Nenhuma alteracao encontrada. Nada a publicar." -ForegroundColor Yellow
    exit 0
}

Write-Host "==> Adicionando arquivos..." -ForegroundColor Cyan
& $GIT add -A

$TIMESTAMP = Get-Date -Format "yyyy-MM-dd HH:mm"
& $GIT commit -m "update: $TIMESTAMP"

Write-Host "==> Enviando para GitHub..." -ForegroundColor Cyan
& $GIT push origin main

Write-Host ""
Write-Host "==> Publicado com sucesso!" -ForegroundColor Green
Write-Host "    URL: https://dashboard-oakberry.vercel.app" -ForegroundColor Cyan
Write-Host "    Vercel atualiza em ~30 segundos." -ForegroundColor Gray
