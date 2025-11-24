# ⚠️ Erros do GitHub Actions - CentralCom

**Última atualização:** 15/01/2025

Este documento explica os erros que aparecem no GitHub Actions após push para `develop` ou `main`, e como lidar com eles.

---

## 🚨 Problema

Após fazer push para `develop` ou `main`, aparecem erros no GitHub Actions:

- ❌ `Publish Chatwoot CE docker images / build (linux/amd64, ubuntu-latest) (push)` - **Failing after 19s**
- ❌ `Publish Chatwoot CE docker images / build (linux/arm64, ubuntu-22.04-arm) (push)` - **Failing after 39s**
- ❌ `Publish Chatwoot EE docker images / build (linux/amd64, ubuntu-latest) (push)` - **Failing after 22s**
- ❌ `Publish Chatwoot EE docker images / build (linux/arm64, ubuntu-22.04-arm) (push)` - **Failing after 34s**

✅ **Checks que passam:**
- `Frontend Lint & Test / test (push)` - **Successful**
- `Run Chatwoot CE spec / test (push)` - **Successful**

---

## 🔍 Análise

### Workflows Envolvidos

Os erros vêm dos workflows do Chatwoot original:
- `.github/workflows/publish_foss_docker.yml` - Publica imagem Docker CE (Community Edition)
- `.github/workflows/publish_ee_docker.yml` - Publica imagem Docker EE (Enterprise Edition)

### Por que estão falhando?

#### 1. **Secrets não configurados**

Os workflows tentam fazer login no DockerHub:

```yaml
- name: Login to DockerHub
  uses: docker/login-action@v3
  with:
    username: ${{ secrets.DOCKERHUB_USERNAME }}
    password: ${{ secrets.DOCKERHUB_TOKEN }}
```

**Problema:**
- Esses secrets (`DOCKERHUB_USERNAME` e `DOCKERHUB_TOKEN`) não estão configurados no nosso fork
- Sem credenciais, o workflow falha ao tentar fazer login

#### 2. **Não precisamos desses workflows**

**Por quê:**
- Usamos nosso próprio `Dockerfile.centralcom`
- Não publicamos imagens no DockerHub oficial do Chatwoot
- Esses workflows são do repositório upstream (Chatwoot original)
- Nossa imagem é construída localmente ou em outro CI/CD

#### 3. **Workflows são ativados automaticamente**

Os workflows estão configurados para rodar em push para `develop` e `master`:

```yaml
on:
  push:
    branches:
      - develop
      - master
```

Como fazemos push para essas branches, os workflows são acionados automaticamente.

---

## 💡 Soluções

### Opção 1: Desabilitar Workflows (Recomendado) ⭐

**Ação:** Adicionar condição para não executar em forks

**Como fazer:**

1. Editar `.github/workflows/publish_foss_docker.yml`
2. Adicionar condição no início do workflow:

```yaml
on:
  push:
    branches:
      - develop
      - master
    tags:
      - v*
  workflow_dispatch:

# Adicionar esta condição
jobs:
  build:
    if: github.repository == 'chatwoot/chatwoot'  # ← ADICIONAR ESTA LINHA
    strategy:
      # ... resto do workflow
```

3. Fazer o mesmo em `.github/workflows/publish_ee_docker.yml`

**Prós:**
- ✅ Mantém workflows originais para referência
- ✅ Não quebra nada se quisermos contribuir upstream
- ✅ Remove erros do GitHub Actions
- ✅ Workflows aparecem como "skipped" (não como erro)

**Contras:**
- ⚠️ Workflows ainda aparecem (mas como "skipped", não "failing")

---

### Opção 2: Remover Workflows

**Ação:** Deletar arquivos dos workflows

**Como fazer:**
```bash
rm .github/workflows/publish_foss_docker.yml
rm .github/workflows/publish_ee_docker.yml
```

**Prós:**
- ✅ Remove erros completamente
- ✅ Limpa interface do GitHub
- ✅ Não há workflows desnecessários

**Contras:**
- ❌ Perde referência dos workflows originais
- ❌ Se quisermos contribuir upstream, precisamos restaurar
- ❌ Perdemos histórico de como o Chatwoot publica imagens

---

### Opção 3: Configurar Secrets (Não recomendado)

**Ação:** Configurar secrets do DockerHub no fork

**Como fazer:**
1. Ir em Settings → Secrets and variables → Actions
2. Adicionar `DOCKERHUB_USERNAME` e `DOCKERHUB_TOKEN`
3. Workflows funcionariam

**Prós:**
- ✅ Workflows funcionariam

**Contras:**
- ❌ Não precisamos publicar imagens
- ❌ Expor credenciais desnecessariamente
- ❌ Custo de build no GitHub Actions (tempo e recursos)
- ❌ Publicaria imagens com nome errado (chatwoot/chatwoot ao invés de nosso nome)

---

## 🎯 Decisão Recomendada

**Opção 1: Desabilitar Workflows com condição**

**Por quê:**
- É a solução mais limpa
- Mantém referência dos workflows originais
- Remove erros sem perder informação
- Fácil de reverter se necessário

---

## 🔧 Implementação

### Passo a Passo

1. **Editar `publish_foss_docker.yml`:**
   ```yaml
   jobs:
     build:
       if: github.repository == 'chatwoot/chatwoot'  # Adicionar esta linha
       strategy:
         # ... resto
   ```

2. **Editar `publish_ee_docker.yml`:**
   ```yaml
   jobs:
     build:
       if: github.repository == 'chatwoot/chatwoot'  # Adicionar esta linha
       strategy:
         # ... resto
   ```

3. **Commit e push:**
   ```bash
   git add .github/workflows/
   git commit -m "chore: desabilitar workflows de publicação Docker (fork)"
   git push origin develop
   ```

4. **Verificar:**
   - Após push, workflows devem aparecer como "skipped" ao invés de "failing"

---

## 📊 Status Atual

**Status:** ⚠️ **Pendente de implementação**

Por enquanto, os erros não afetam o funcionamento do sistema. Podemos:
1. ✅ Ignorar (não crítico) - **Atual**
2. 🔧 Desabilitar workflows (Opção 1) - **Recomendado**
3. 🗑️ Remover workflows (Opção 2)

---

## 🔄 Próximos Passos

- [ ] Implementar Opção 1 (desabilitar workflows)
- [ ] Verificar se outros workflows também precisam ser desabilitados
- [ ] Documentar decisão no `HISTORICO_MODIFICACOES.md`

---

## 📝 Notas

- Esses workflows são do repositório upstream (Chatwoot original)
- Não são necessários para nosso fork
- Erros são cosméticos (não afetam funcionalidade)
- Podemos ignorar ou desabilitar conforme preferência

---

**Última atualização:** 15/01/2025

