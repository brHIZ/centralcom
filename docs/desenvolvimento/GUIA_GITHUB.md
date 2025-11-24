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
   - [4.1. Entendendo Disco vs. Memória do Cursor vs. Git/GitHub](#41-entendendo-disco-vs-memória-do-cursor-vs-gitgithub)
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
# Estrutura recomendada: /root/repos/centralcom/
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

## 4.1. Entendendo Disco vs. Memória do Cursor vs. Git/GitHub

### ⚠️ Dúvida Comum: "O Git foi sincronizado mesmo se eu não aceitei no Cursor?"

**Resposta curta: Sim! O Git trabalha com o disco, não com a memória do Cursor.**

### Como Funciona o Processo

#### 1. **Quando arquivos são modificados:**

```
IA modifica arquivo → Escrito DIRETAMENTE no DISCO
                    ↓
              Git lê do DISCO
```

- As modificações são escritas diretamente no disco
- O Git sempre trabalha com o que está no disco
- O Cursor mantém uma cópia em memória para edição

#### 2. **Quando você faz `git add` e `git commit`:**

```
git add arquivo → Git lê do DISCO e adiciona ao staging
git commit      → Git lê do DISCO e cria commit
```

- O Git lê do disco, não da memória do Cursor
- O commit acontece mesmo se o Cursor mostrar "não aceito"
- O que está no disco é o que importa para o Git

#### 3. **O que o Cursor mostra como "não aceito":**

```
Cursor em memória ≠ Disco
         ↓
    Mostra "não aceito"
```

- É apenas uma diferença entre memória do Cursor e disco
- Não afeta o Git, que já trabalhou com o arquivo no disco
- É apenas uma questão de interface/sincronização visual

#### 4. **Quando você aceita no Cursor:**

```
Você aceita → Cursor sincroniza memória com DISCO
            → Apenas atualiza interface
            → NÃO altera o que foi commitado
```

- O Cursor apenas sincroniza sua interface com o disco
- Não altera o que já foi commitado pelo Git
- É apenas uma atualização visual

### Fluxo Visual Completo

```
┌─────────────────────────────────────────────────────────┐
│ 1. IA modifica arquivo                                   │
│    → Escrito no DISCO ✅                                 │
└─────────────────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────────────────┐
│ 2. IA faz git add/commit                                 │
│    → Git lê do DISCO ✅                                  │
│    → Commit criado ✅                                     │
│    → Push para GitHub ✅                                  │
└─────────────────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────────────────┐
│ 3. Cursor mostra "não aceito"                            │
│    → Apenas interface (memória vs disco)                 │
│    → Git JÁ commitou ✅                                   │
└─────────────────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────────────────┐
│ 4. Você aceita no Cursor                                 │
│    → Sincroniza interface com DISCO                       │
│    → Git JÁ estava sincronizado ✅                       │
└─────────────────────────────────────────────────────────┘
```

### Como Verificar se Está Realmente Sincronizado

```bash
cd /root/repos/centralcom

# 1. Verificar status
git status
# Se mostrar "up to date" e "nothing to commit" → ✅ Sincronizado!

# 2. Verificar se há diferenças no disco
git diff HEAD
# Se não mostrar nada → ✅ Tudo commitado!

# 3. Verificar se há arquivos staged
git diff --cached
# Se não mostrar nada → ✅ Nada pendente!

# 4. Verificar últimos commits
git log --oneline -5
# Mostra os commits que foram feitos → ✅ Confirmado!
```

### Resumo Importante

| Situação | Git/GitHub | Cursor | Status |
|----------|------------|--------|--------|
| Arquivo modificado no disco | ✅ Lê do disco | ⚠️ Mostra "não aceito" | Git funciona normalmente |
| `git commit` executado | ✅ Commit criado | ⚠️ Ainda mostra "não aceito" | **Git já sincronizou!** |
| Você aceita no Cursor | ✅ Já estava OK | ✅ Interface sincronizada | Tudo OK |

### ⚠️ Pontos Importantes

1. **Git trabalha com disco:** O Git sempre lê/escreve do disco, não da memória do Cursor
2. **Cursor é interface:** O "não aceito" é apenas visual, não afeta o Git
3. **Commits são reais:** Se `git status` mostra "nothing to commit", está tudo commitado
4. **Aceitar no Cursor:** Apenas sincroniza interface, não altera commits já feitos

### 💡 Dica

**Se você está em dúvida se algo foi commitado:**
```bash
git status
```

**Se mostrar:**
- `"Your branch is up to date with 'origin/develop'"` → ✅ Sincronizado
- `"nothing to commit, working tree clean"` → ✅ Tudo commitado

**Então está tudo OK, mesmo que o Cursor ainda mostre "não aceito"!**

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

## 6. Trabalhando com o Repositório Original (Upstream)

### O que é o Remote "Upstream"?

O repositório CentralCom tem um remote chamado `upstream` que aponta para o repositório original do Chatwoot:

```bash
git remote -v
# origin    git@github.com:brHIZ/centralcom.git (seu fork)
# upstream  https://github.com/chatwoot/chatwoot.git (original)
```

### Buscar Atualizações do Chatwoot Original

```bash
# Buscar todas as atualizações do upstream
git fetch upstream

# Buscar atualizações de uma branch específica
git fetch upstream develop

# Ver commits novos do Chatwoot original
git log develop..upstream/develop --oneline
```

### Comparar com o Chatwoot Original

```bash
# Ver diferenças entre seu fork e o original
git diff develop..upstream/develop

# Ver apenas arquivos diferentes
git diff --name-only develop..upstream/develop

# Ver estatísticas de mudanças
git diff --stat develop..upstream/develop
```

### Copiar Arquivo do Original

```bash
# Copiar um arquivo específico do Chatwoot original
git checkout upstream/develop -- caminho/para/arquivo

# Exemplo: copiar um componente Vue do original
git checkout upstream/develop -- app/javascript/v3/components/Button/Index.vue
```

### Ver Logs do Original

```bash
# Ver commits do Chatwoot original
git log upstream/develop --oneline -20

# Ver commits de uma branch específica do original
git log upstream/master --oneline -10
```

### Atualizar Fork com Mudanças do Original

**⚠️ CUIDADO:** Isso pode sobrescrever suas customizações!

```bash
# 1. Garantir que está em develop
git checkout develop

# 2. Buscar atualizações
git fetch upstream

# 3. Ver o que mudou (IMPORTANTE: revisar antes de fazer merge)
git log develop..upstream/develop --oneline

# 4. Se quiser mesclar (pode haver conflitos)
git merge upstream/develop

# 5. Resolver conflitos se houver
# 6. Testar tudo
# 7. Push
git push origin develop
```

### Precisa de um Clone Local Separado?

**Resposta curta: ❌ Não é necessário.**

O remote `upstream` já permite:
- ✅ Buscar atualizações (`git fetch upstream`)
- ✅ Comparar código (`git diff develop..upstream/develop`)
- ✅ Ver commits (`git log upstream/develop`)
- ✅ Copiar arquivos (`git checkout upstream/develop -- arquivo`)

**Estrutura recomendada:**
```
/root/repos/
└── centralcom/          # Apenas seu fork customizado
    ├── .git/
    │   ├── remotes:
    │   │   ├── origin → seu GitHub
    │   │   └── upstream → Chatwoot original
    └── ...
```

**❌ Não criar:**
- `/root/repos/chatwoot-oficial/` - **NÃO é necessário**
- `/root/centralcom/` - Use `/root/repos/centralcom/` para manter organização

**📁 Por que `/root/repos/`?**
- ✅ Escalabilidade: Facilita adicionar outros repositórios GitHub no futuro
- ✅ Organização: Mantém todos os repositórios em um local centralizado
- ✅ Consistência: Padrão comum em servidores de desenvolvimento

**Quando considerar um clone local (raro):**
- Se você precisa comparar arquivos visualmente com frequência
- Se você quer ter uma versão "limpa" sempre disponível para referência
- Se você trabalha offline frequentemente

**⚠️ Se decidir criar (não recomendado):**
```bash
# Criar clone do Chatwoot original em /root/repos/chatwoot-oficial
cd /root/repos
git clone https://github.com/chatwoot/chatwoot.git chatwoot-oficial
cd chatwoot-oficial
git checkout develop  # ou a versão que você usa
```

**⚠️ Lembre-se:**
- O clone ocupará ~362MB de espaço em disco
- Precisa ser atualizado manualmente (`git pull` no clone)
- O remote `upstream` já fornece a maioria das funcionalidades
- **Recomendação:** Não criar, usar apenas o remote `upstream`

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

### 🚨 Erros do GitHub Actions - Explicação Completa

Após push para `develop` ou `main`, aparecem erros no GitHub Actions:

- ❌ `Publish Chatwoot CE docker images / build (linux/amd64)` - **Failing**
- ❌ `Publish Chatwoot CE docker images / build (linux/arm64)` - **Failing**
- ❌ `Publish Chatwoot EE docker images / build (linux/amd64)` - **Failing**
- ❌ `Publish Chatwoot EE docker images / build (linux/arm64)` - **Failing**

**Erro específico:** `Error: Username and password required` no step "Login to DockerHub"

### 📍 Onde Isso Está Configurado?

Os workflows estão em:
- `.github/workflows/publish_foss_docker.yml` - Publica imagem CE (Community Edition)
- `.github/workflows/publish_ee_docker.yml` - Publica imagem EE (Enterprise Edition)

**Linha problemática (linha 67-72 em ambos os arquivos):**
```yaml
- name: Login to DockerHub
  if: github.event_name == 'push' || github.event_name == 'workflow_dispatch'
  uses: docker/login-action@v3
  with:
    username: ${{ secrets.DOCKERHUB_USERNAME }}  # ← Secret não configurado
    password: ${{ secrets.DOCKERHUB_TOKEN }}      # ← Secret não configurado
```

**Quando são ativados (linha 9-16):**
```yaml
on:
  push:
    branches:
      - develop    # ← Ativado quando você faz push para develop
      - master     # ← Ativado quando você faz push para master/main
    tags:
      - v*
  workflow_dispatch:
```

### Por que estão falhando?

#### 1. **Secrets não configurados**

Os workflows tentam fazer login no DockerHub usando secrets do GitHub:
- `secrets.DOCKERHUB_USERNAME` - Usuário do DockerHub
- `secrets.DOCKERHUB_TOKEN` - Token de acesso do DockerHub

**Problema:**
- Esses secrets não estão configurados no nosso fork
- O GitHub Actions não consegue fazer login no DockerHub
- O workflow falha com erro: `Error: Username and password required`

**Onde configurar secrets (se quisesse):**
1. Ir em: GitHub → Settings → Secrets and variables → Actions
2. Adicionar `DOCKERHUB_USERNAME` e `DOCKERHUB_TOKEN`
3. ⚠️ **Mas não precisamos fazer isso!** (veja abaixo)

#### 2. **Não precisamos desses workflows**

**Por quê:**
- ✅ Usamos nosso próprio `Dockerfile.centralcom`
- ✅ Não publicamos imagens no DockerHub oficial do Chatwoot
- ✅ Esses workflows são do repositório upstream (Chatwoot original)
- ✅ Nossa imagem é construída localmente ou em outro CI/CD
- ✅ Publicar no DockerHub oficial não faz sentido (seria com nome errado: `chatwoot/chatwoot`)

**O que esses workflows fazem:**
- Tentam publicar imagens Docker no DockerHub com nome `chatwoot/chatwoot`
- Isso é para o repositório oficial do Chatwoot
- Não é necessário para nosso fork

#### 3. **Workflows são ativados automaticamente**

Os workflows estão configurados para rodar automaticamente em push para `develop` e `master`:
```yaml
on:
  push:
    branches:
      - develop    # ← Ativa quando você faz push
      - master     # ← Ativa quando você faz push
```

Como fazemos push para essas branches, os workflows são acionados automaticamente, mesmo que não precisemos deles.

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

#### Opção 3: Configurar Secrets (NÃO Recomendado)

**Ação:** Configurar secrets do DockerHub no fork

**Como fazer:**
1. Ir em: GitHub → Settings → Secrets and variables → Actions
2. Adicionar `DOCKERHUB_USERNAME` e `DOCKERHUB_TOKEN`
3. Workflows funcionariam

**Prós:**
- ✅ Workflows funcionariam

**Contras:**
- ❌ Não precisamos publicar imagens
- ❌ Expor credenciais desnecessariamente
- ❌ Custo de build no GitHub Actions (tempo e recursos)
- ❌ Publicaria imagens com nome errado (`chatwoot/chatwoot` ao invés de nosso nome)
- ❌ Não faz sentido para nosso fork

**⚠️ NÃO RECOMENDADO!**

---

#### Opção 4: Ignorar (Atual)

**Ação:** Não fazer nada

**Status:** ⚠️ **Atual**

Os erros não afetam o funcionamento do sistema. Podemos ignorar ou desabilitar conforme preferência.

**Prós:**
- ✅ Não requer mudanças
- ✅ Não afeta funcionalidade

**Contras:**
- ❌ Interface do GitHub mostra erros
- ❌ Pode confundir ao ver "checks failing"

---

### 🎯 Recomendação

**Opção 1: Desabilitar Workflows com condição** ⭐

**Por quê:**
- É a solução mais limpa
- Mantém referência dos workflows originais
- Remove erros sem perder informação
- Fácil de reverter se necessário
- Não quebra nada se quisermos contribuir upstream

### 📝 Status Atual

**Status:** ⚠️ **Pendente de implementação**

Por enquanto, os erros não afetam o funcionamento. **Recomendação:** Implementar Opção 1 quando houver tempo.

**📚 Ver mais:** [`HISTORICO_MODIFICACOES.md`](./HISTORICO_MODIFICACOES.md) - Seção "Erros do GitHub Actions"

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
# 1. Ir para o diretório do repositório
cd /root/repos/centralcom

# 2. Verificar branch
git branch

# 3. Se não estiver em develop, mudar
git checkout develop

# 4. Atualizar
git pull origin develop

# 5. Fazer modificações...

# 6. Adicionar arquivos
git add .

# 7. Ver o que será commitado
git status

# 8. Fazer commit
git commit -m "tipo: descrição"

# 9. Push
git push origin develop

# 10. Após validação, merge para main
git checkout main
git pull origin main
git merge develop
git push origin main
git checkout develop
```

**📁 Estrutura:**
- **Repositório:** `/root/repos/centralcom/` (recomendado para escalabilidade)
- **Remotes:** `origin` (seu GitHub) e `upstream` (Chatwoot original)
- **Branches:** `develop` (desenvolvimento) e `main` (produção)
- **❌ Não criar:** `/root/repos/chatwoot-oficial/` - não é necessário

---

## 📚 Recursos Adicionais

- **Documentação Git:** https://git-scm.com/doc
- **GitHub Docs:** https://docs.github.com
- **Convenção de Commits:** https://www.conventionalcommits.org

---

**Última atualização:** 15/01/2025

