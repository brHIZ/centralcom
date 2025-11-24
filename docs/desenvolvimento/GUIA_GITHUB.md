# 🔀 Guia de GitHub - CentralCom

**Última atualização:** 15/01/2025

Este guia explica como trabalhar corretamente com Git e GitHub no fork CentralCom, incluindo branches, commits, merges e como navegar entre versões.

---

## 🎯 Objetivo

Facilitar o trabalho com Git/GitHub, evitando confusões sobre:
- Qual branch usar
- Como fazer commits corretamente
- Como fazer merge/push/pull
- Como saber se está na versão correta
- Como navegar entre versões

---

## 📋 Índice

1. [Estrutura de Branches](#1-estrutura-de-branches)
2. [Workflow de Desenvolvimento](#2-workflow-de-desenvolvimento)
3. [Comandos Essenciais](#3-comandos-essenciais)
4. [Como Saber se Está na Versão Correta](#4-como-saber-se-está-na-versão-correta)
5. [Navegação entre Versões](#5-navegação-entre-versões)
6. [Problemas Comuns](#6-problemas-comuns)
7. [GitHub Actions](#7-github-actions)

---

## 1. Estrutura de Branches

### Branches Principais

```
centralcom/
├── main          # Branch de produção (estável)
├── develop       # Branch de desenvolvimento (ativa)
└── upstream/*    # Branches do repositório original (Chatwoot)
```

### **`main`** - Branch de Produção
- **Uso:** Código estável, pronto para produção
- **Quando usar:** Apenas para merge de `develop` após validação
- **⚠️ NUNCA commitar diretamente em `main`**

### **`develop`** - Branch de Desenvolvimento
- **Uso:** Branch principal para desenvolvimento
- **Quando usar:** Sempre que for fazer modificações
- **✅ SEMPRE trabalhar em `develop`**

### **`upstream/*`** - Repositório Original
- **Uso:** Referência ao repositório original do Chatwoot
- **Não modificar:** Apenas para referência e atualizações

---

## 2. Workflow de Desenvolvimento

### Fluxo Padrão

```
1. Verificar branch atual
   ↓
2. Garantir que está em 'develop'
   ↓
3. Fazer modificações
   ↓
4. Adicionar arquivos (git add)
   ↓
5. Fazer commit (git commit)
   ↓
6. Push para 'develop' (git push origin develop)
   ↓
7. Testar e validar
   ↓
8. Merge para 'main' (git checkout main && git merge develop)
   ↓
9. Push para 'main' (git push origin main)
```

### Passo a Passo Detalhado

#### **1. Verificar Branch Atual**
```bash
cd /root/repos/centralcom
git branch
# Deve mostrar: * develop
```

#### **2. Se não estiver em develop, mudar:**
```bash
git checkout develop
```

#### **3. Garantir que está atualizado:**
```bash
git pull origin develop
```

#### **4. Fazer modificações nos arquivos**

#### **5. Adicionar arquivos modificados:**
```bash
# Adicionar arquivo específico
git add caminho/para/arquivo

# Adicionar todos os arquivos modificados
git add .

# Ver o que será commitado
git status
```

#### **6. Fazer commit:**
```bash
git commit -m "tipo: descrição clara do que foi feito

- Detalhe 1
- Detalhe 2
- Detalhe 3"
```

**Tipos de commit (convenção):**
- `feat:` - Nova funcionalidade
- `fix:` - Correção de bug
- `docs:` - Documentação
- `chore:` - Tarefas de manutenção
- `refactor:` - Refatoração de código
- `style:` - Formatação (não afeta funcionalidade)

#### **7. Push para develop:**
```bash
git push origin develop
```

#### **8. Após validação, merge para main:**
```bash
# Mudar para main
git checkout main

# Atualizar main
git pull origin main

# Fazer merge de develop
git merge develop

# Push para main
git push origin main

# Voltar para develop
git checkout develop
```

---

## 3. Comandos Essenciais

### Verificar Status

```bash
# Ver branch atual
git branch

# Ver status (arquivos modificados, staged, etc)
git status

# Ver histórico de commits
git log --oneline -10

# Ver diferenças
git diff
```

### Navegação

```bash
# Mudar de branch
git checkout nome-da-branch

# Criar nova branch (se necessário)
git checkout -b nova-branch

# Voltar para develop
git checkout develop
```

### Adicionar e Commitar

```bash
# Adicionar arquivo específico
git add arquivo.txt

# Adicionar todos os arquivos modificados
git add .

# Ver o que será commitado
git status

# Fazer commit
git commit -m "mensagem descritiva"

# Fazer commit com mensagem longa
git commit -m "título" -m "descrição detalhada"
```

### Push e Pull

```bash
# Push para branch atual
git push origin develop

# Pull (atualizar) branch atual
git pull origin develop

# Ver remotes configurados
git remote -v
```

### Merge

```bash
# Estar na branch de destino (ex: main)
git checkout main

# Fazer merge de outra branch (ex: develop)
git merge develop

# Se houver conflitos, resolver e depois:
git add .
git commit -m "merge: resolver conflitos"
```

---

## 4. Como Saber se Está na Versão Correta

### Verificar Branch Atual

```bash
cd /root/repos/centralcom
git branch
```

**Saída esperada:**
```
* develop
  main
```

O `*` indica a branch atual.

### Verificar Status do Repositório

```bash
git status
```

**Saída esperada quando tudo está OK:**
```
On branch develop
Your branch is up to date with 'origin/develop'.

nothing to commit, working tree clean
```

**Se houver modificações:**
```
On branch develop
Your branch is up to date with 'origin/develop'.

Changes not staged for commit:
  modified:   arquivo.txt
```

### Verificar Último Commit

```bash
git log --oneline -1
```

**Exemplo:**
```
891257630 feat: aumentar tamanho do logo na página de login
```

### Verificar Diferenças com Remote

```bash
# Ver diferenças entre local e remote
git fetch origin
git log HEAD..origin/develop

# Se não houver saída, está sincronizado
```

---

## 5. Navegação entre Versões

### Ver Todas as Branches

```bash
# Branches locais
git branch

# Todas as branches (incluindo remotes)
git branch -a
```

### Mudar de Branch

```bash
# Mudar para main
git checkout main

# Mudar para develop
git checkout develop

# Mudar para branch específica
git checkout nome-da-branch
```

### Ver Commits de uma Branch

```bash
# Ver commits da branch atual
git log --oneline -10

# Ver commits de outra branch
git log --oneline -10 nome-da-branch

# Ver diferenças entre branches
git diff develop..main
```

### Verificar se Branch está Atualizada

```bash
# Atualizar referências remotas
git fetch origin

# Ver se há diferenças
git log HEAD..origin/develop

# Se não houver saída, está atualizado
```

---

## 6. Problemas Comuns

### Problema 1: "Estou na branch errada"

**Sintoma:**
```bash
git branch
# Mostra: * main (mas queria estar em develop)
```

**Solução:**
```bash
git checkout develop
```

---

### Problema 2: "Tenho modificações não commitadas"

**Sintoma:**
```bash
git checkout develop
# Erro: "Your local changes to the following files would be overwritten"
```

**Solução:**

**Opção A - Salvar modificações (stash):**
```bash
# Salvar modificações temporariamente
git stash

# Mudar de branch
git checkout develop

# Recuperar modificações depois
git stash pop
```

**Opção B - Commitar modificações:**
```bash
git add .
git commit -m "WIP: modificações em progresso"
git checkout develop
```

---

### Problema 3: "Branch está desatualizada"

**Sintoma:**
```bash
git push origin develop
# Erro: "Updates were rejected because the remote contains work"
```

**Solução:**
```bash
# Atualizar branch local
git pull origin develop

# Resolver conflitos se houver
# Depois fazer push novamente
git push origin develop
```

---

### Problema 4: "Fiz commit na branch errada"

**Sintoma:**
Fez commit em `main` ao invés de `develop`

**Solução:**
```bash
# Mover último commit para develop
git checkout develop
git cherry-pick <hash-do-commit>
git checkout main
git reset --hard HEAD~1  # Remove commit de main
```

---

### Problema 5: "Não sei qual versão está rodando"

**Sintoma:**
Não sabe se o deploy está usando `main` ou `develop`

**Solução:**
```bash
# Ver último commit de cada branch
git log --oneline -1 main
git log --oneline -1 develop

# Verificar qual commit está no servidor
# (depende de como o deploy é feito)
```

---

## 7. GitHub Actions

### Erros do GitHub Actions

Após push para `develop` ou `main`, podem aparecer erros no GitHub Actions:

- ❌ `Publish Chatwoot CE docker images / build` - **Failing**
- ❌ `Publish Chatwoot EE docker images / build` - **Failing**

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
- Esses secrets não estão configurados no nosso fork
- Sem credenciais, o workflow falha

#### 2. **Não precisamos desses workflows**

**Por quê:**
- Usamos nosso próprio `Dockerfile.centralcom`
- Não publicamos imagens no DockerHub oficial
- Esses workflows são do repositório upstream (Chatwoot original)
- Nossa imagem é construída localmente

#### 3. **Workflows são ativados automaticamente**

Os workflows estão configurados para rodar em push para `develop` e `master`:
```yaml
on:
  push:
    branches:
      - develop
      - master
```

Como fazemos push para essas branches, os workflows são acionados.

### Soluções

#### Opção 1: Desabilitar Workflows (Recomendado) ⭐

**Ação:** Adicionar condição para não executar em forks

**Como fazer:**

1. Editar `.github/workflows/publish_foss_docker.yml`
2. Adicionar condição no início do job:

```yaml
jobs:
  build:
    if: github.repository == 'chatwoot/chatwoot'  # ← ADICIONAR ESTA LINHA
    strategy:
      # ... resto do workflow
```

3. Fazer o mesmo em `.github/workflows/publish_ee_docker.yml`

4. Commit e push:
```bash
git add .github/workflows/
git commit -m "chore: desabilitar workflows de publicação Docker (fork)"
git push origin develop
```

**Prós:**
- ✅ Mantém workflows originais para referência
- ✅ Remove erros do GitHub Actions
- ✅ Workflows aparecem como "skipped" (não como erro)

---

#### Opção 2: Remover Workflows

**Ação:** Deletar arquivos dos workflows

```bash
rm .github/workflows/publish_foss_docker.yml
rm .github/workflows/publish_ee_docker.yml
```

**Prós:**
- ✅ Remove erros completamente
- ✅ Limpa interface do GitHub

**Contras:**
- ❌ Perde referência dos workflows originais

---

#### Opção 3: Ignorar (Atual)

**Ação:** Não fazer nada

**Status:** ⚠️ **Atual**

Os erros não afetam o funcionamento do sistema. Podemos ignorar ou desabilitar conforme preferência.

---

### Status Atual

**Status:** ⚠️ **Pendente de implementação**

Por enquanto, os erros não afetam o funcionamento. Recomendação: Implementar Opção 1 quando houver tempo.

---

## 📝 Checklist Antes de Commitar

Antes de fazer commit, sempre verificar:

- [ ] Estou na branch `develop`? (`git branch`)
- [ ] Branch está atualizada? (`git pull origin develop`)
- [ ] Vejo o que será commitado? (`git status`)
- [ ] Mensagem de commit é clara e descritiva?
- [ ] Não há arquivos sensíveis (senhas, credenciais)?
- [ ] Testei as modificações localmente?

---

## 🔄 Workflow Resumido

```bash
# 1. Verificar branch
git branch

# 2. Se não estiver em develop, mudar
git checkout develop

# 3. Atualizar
git pull origin develop

# 4. Fazer modificações...

# 5. Adicionar arquivos
git add .

# 6. Ver o que será commitado
git status

# 7. Fazer commit
git commit -m "tipo: descrição"

# 8. Push
git push origin develop

# 9. Após validação, merge para main
git checkout main
git pull origin main
git merge develop
git push origin main
git checkout develop
```

---

## 📚 Recursos Adicionais

- **Documentação Git:** https://git-scm.com/doc
- **GitHub Docs:** https://docs.github.com
- **Convenção de Commits:** https://www.conventionalcommits.org

---

**Última atualização:** 15/01/2025

