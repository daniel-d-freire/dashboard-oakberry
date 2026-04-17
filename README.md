# Oakberry PUC — Análise de Produtos

Dashboard de vendas por produto da loja Oakberry PUC (Loja 5002).  
Arquivo HTML estático — sem banco de dados, sem servidor.

## Como atualizar

1. Exportar relatório **Venda de Produtos** do sistema Oakberry (período = mês fechado)
2. Enviar o `.xls` ao Claude no projeto
3. Claude processa e atualiza o `index.html` automaticamente
4. Rodar `.\deploy-produtos.ps1` para publicar

## Deploy
- GitHub: repositório privado compartilhado
- Vercel: auto-deploy a cada push no `main`
