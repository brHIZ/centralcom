# 📚 Documentação de Desenvolvimento - CentralCom

Esta pasta contém documentação técnica sobre o desenvolvimento e customização do CentralCom (fork do Chatwoot).

---

## 📋 Documentos Disponíveis

### 1. [`HISTORICO_MODIFICACOES.md`](./HISTORICO_MODIFICACOES.md)
**Registro detalhado de todas as modificações realizadas**

- Tentativas, sucessos e falhas
- Explicação do "porquê" de cada decisão
- Lições aprendidas
- Processo completo de cada customização

**Use quando:**
- Quiser entender o histórico de uma modificação
- Precisar saber por que algo foi feito de determinada forma
- Quiser evitar repetir erros já enfrentados

---

### 2. [`GUIA_ESTRUTURA_CODIGO.md`](./GUIA_ESTRUTURA_CODIGO.md)
**Referência rápida sobre estrutura do código fonte**

- Onde encontrar arquivos importantes
- Estrutura de diretórios
- Onde modificar funcionalidades específicas
- Convenções e padrões do projeto

**Use quando:**
- Precisar encontrar onde modificar algo
- Quiser entender a estrutura do projeto
- Precisar de referência rápida

---

### 3. [`GUIA_GITHUB.md`](./GUIA_GITHUB.md)
**Guia completo de Git e GitHub**

- Como trabalhar com branches (develop/main)
- Como fazer commits, merges, push/pull corretamente
- Como saber se está na versão correta
- Como navegar entre versões
- Problemas comuns e soluções
- Erros do GitHub Actions e como resolver

**Use quando:**
- Estiver confuso sobre qual branch usar
- Não souber como fazer commit/merge/push
- Precisar verificar se está na versão correta
- Ver erros no GitHub Actions

---

## 🎯 Como Usar Esta Documentação

### Para Desenvolvedores Novos
1. Comece pelo [`GUIA_ESTRUTURA_CODIGO.md`](./GUIA_ESTRUTURA_CODIGO.md) para entender a estrutura
2. Leia [`HISTORICO_MODIFICACOES.md`](./HISTORICO_MODIFICACOES.md) para entender o que já foi feito

### Para Modificações Futuras
1. Consulte [`GUIA_ESTRUTURA_CODIGO.md`](./GUIA_ESTRUTURA_CODIGO.md) para encontrar onde modificar
2. Documente no [`HISTORICO_MODIFICACOES.md`](./HISTORICO_MODIFICACOES.md) após concluir

### Para Troubleshooting
1. Verifique [`HISTORICO_MODIFICACOES.md`](./HISTORICO_MODIFICACOES.md) para problemas similares já enfrentados
2. Consulte [`ERROS_GITHUB_ACTIONS.md`](./ERROS_GITHUB_ACTIONS.md) se houver erros no CI/CD

---

## 🔄 Manutenção

**Esta documentação deve ser atualizada sempre que:**
- Nova modificação significativa for feita
- Nova estrutura de código for descoberta
- Novo erro ou problema for identificado
- Decisão técnica importante for tomada

**Formato:**
- Manter consistência entre documentos
- Adicionar data de atualização
- Explicar o "porquê" das decisões
- Incluir exemplos práticos quando possível

---

## 📝 Outros Documentos Relacionados

- [`ESPECIFICACOES_LOGO_FAVICON.md`](../../ESPECIFICACOES_LOGO_FAVICON.md) - Especificações técnicas de logos e favicons
- [`Dockerfile.centralcom`](../../Dockerfile.centralcom) - Dockerfile customizado

**Nota:** O conteúdo de `VERIFICACAO_ICONES.md` foi integrado ao [`HISTORICO_MODIFICACOES.md`](./HISTORICO_MODIFICACOES.md) na seção "Customização de Logo e Favicon".

---

**Última atualização:** 15/01/2025

