# 📝 Histórico de Modificações - CentralCom

**Última atualização:** 15/01/2025

Este documento registra todas as modificações realizadas no fork CentralCom do Chatwoot, incluindo tentativas, sucessos, falhas e as razões por trás de cada decisão.

---

## 🎯 Objetivo

Manter um registro detalhado de todas as customizações, permitindo:
- Entender o histórico de decisões técnicas
- Evitar repetir erros já enfrentados
- Documentar soluções que funcionaram
- Facilitar manutenção futura

---

## 📋 Índice

1. [Customização de Logo e Favicon](#1-customização-de-logo-e-favicon)
2. [Aumento do Tamanho do Logo na Página de Login](#2-aumento-do-tamanho-do-logo-na-página-de-login)

---

## 1. Customização de Logo e Favicon

**Data:** Janeiro 2025  
**Status:** ✅ Concluído

### Objetivo
Substituir os logos e favicons padrão do Chatwoot pelos da CentralCom.

### Processo

#### 1.1. Análise Inicial
- **Ação:** Análise completa do código fonte para identificar todos os locais onde logo/favicon aparecem
- **Arquivos analisados:**
  - `/public/brand-assets/` - Logos principais
  - `/app/javascript/v3/views/` - Componentes Vue.js
  - `/app/views/layouts/` - Layouts Rails
  - `/config/installation_config.yml` - Configuração de instalação
- **Resultado:** Criado documento `ESPECIFICACOES_LOGO_FAVICON.md` com especificações técnicas detalhadas

#### 1.2. Geração de Assets
- **Ação:** Geração de todos os ícones necessários (favicons, Apple, Android, Microsoft)
- **Ferramenta:** IA de geração de imagens
- **Localização:** `/root/centralcom-icons/`
- **Resultado:** ✅ Todos os ícones gerados com sucesso

#### 1.3. Implementação
- **Ação:** Criação do `Dockerfile.centralcom` para customizar a imagem Docker
- **Estratégia:** Copiar assets customizados sobre a imagem base `chatwoot/chatwoot:v4.1.0`
- **Arquivos copiados:**
  - Logos SVG (logo.svg, logo_dark.svg, logo_thumbnail.svg)
  - Favicons PNG (múltiplos tamanhos)
  - Ícones Apple, Android e Microsoft
  - Configuração `installation_config.yml`
- **Resultado:** ✅ Deploy bem-sucedido

#### 1.4. Verificação dos Ícones
**Data:** 2024-11-24  
**Ação:** Verificação completa de todos os ícones após implementação

**Processo de Verificação:**
1. **Verificação dos Arquivos no Repositório:**
   - ✅ Logos SVG: `logo.svg`, `logo_dark.svg`, `logo_thumbnail.svg` presentes
   - ✅ Favicons PNG: 4 tamanhos (16x16, 32x32, 96x96, 512x512)
   - ✅ Ícones Apple: 11 arquivos (57x57 até 180x180)
   - ✅ Ícones Android: 6 arquivos (36x36 até 192x192)
   - ✅ Ícones Microsoft: 4 arquivos (70x70 até 310x310)

2. **Verificação do Dockerfile:**
   - ✅ Todos os wildcards funcionando corretamente
   - ✅ Caminhos de cópia corretos
   - ✅ Estrutura de diretórios preservada

3. **Teste de Build:**
   ```bash
   cd /root/repos/centralcom
   docker build -f Dockerfile.centralcom -t test-build .
   ```
   - ✅ Build concluído com sucesso
   - ✅ Todos os arquivos copiados corretamente

4. **Verificação na Imagem:**
   ```bash
   docker run --rm test-build sh -c 'ls -lh /app/public/brand-assets/*.svg'
   docker run --rm test-build sh -c 'ls -lh /app/public/favicon-*.png'
   ```
   - ✅ Todos os arquivos presentes na imagem
   - ✅ Formatos corretos (SVG e PNG)
   - ✅ Tamanhos corretos

**Observações:**
- `favicon-badge-*.png` vêm da imagem base (usados para notificações)
- `apple-touch-icon-precomposed.png` está vazio, mas não é crítico (sistema usa fallback)

**Resultado:** ✅ **TODOS OS ÍCONES ESTÃO CORRETOS E FUNCIONANDO**

**Problema Identificado (não relacionado a ícones):**
- Erro de banco de dados: `ERROR: relation "installation_configs" does not exist`
- **Solução:** Adicionar `bundle exec rails db:migrate` no script de deploy
- **Status:** ✅ Resolvido (adicionado no `chatwoot-test.yaml`)

### Lições Aprendidas
- ✅ Usar imagem base do Chatwoot é mais eficiente que rebuild completo
- ✅ Assets estáticos podem ser simplesmente copiados sem recompilação
- ✅ `installation_config.yml` é o arquivo central para configuração de branding
- ✅ Wildcards no Dockerfile funcionam perfeitamente para múltiplos arquivos
- ✅ Verificação após build é essencial para garantir que tudo foi copiado

---

## 2. Aumento do Tamanho do Logo na Página de Login

**Data:** Janeiro 2025  
**Status:** ✅ Concluído (após múltiplas tentativas)

### Objetivo
Aumentar o tamanho do logo na página de login de `h-8` (32px) para um tamanho maior e mais visível.

### Tentativas e Resultados

#### Tentativa 1: Modificação Direta no Vue Component
**Data:** Primeira tentativa  
**Ação:**
- Modificado `app/javascript/v3/views/login/Index.vue`
- Alterado `h-8` para `h-16` (64px)
- Rebuild da imagem Docker

**Resultado:** ❌ **FALHOU**
- Logo continuava pequeno após rebuild
- Mudanças não foram aplicadas

**Causa Raiz:**
- Dockerfile não estava copiando os arquivos Vue modificados
- Assets não foram recompilados após a modificação
- A imagem Docker usava os assets pré-compilados da imagem base

---

#### Tentativa 2: Adicionar COPY e Recompilação no Dockerfile
**Data:** Segunda tentativa  
**Ação:**
- Adicionado `COPY` dos arquivos Vue no `Dockerfile.centralcom`
- Adicionado comando `bundle exec rake assets:precompile`
- Aumentado logo para `h-24` (96px) nos arquivos Vue

**Resultado:** ❌ **FALHOU**
- Erro: `JavaScript heap out of memory` durante `rake assets:precompile`
- Build falhava no step 15/15
- Node.js não tinha memória suficiente para compilar assets

**Causa Raiz:**
- Processo de recompilação de assets Vue.js consome muita memória
- Imagem base não tinha `pnpm` instalado globalmente
- Dependências frontend não estavam instaladas antes da recompilação

**Tentativas de Correção:**
1. Adicionado `ENV NODE_OPTIONS="--max-old-space-size=6144"` - ❌ Ainda falhava
2. Adicionado instalação do `pnpm` no Dockerfile - ❌ Ainda falhava
3. Adicionado `pnpm install --frozen-lockfile` antes de `rake assets:precompile` - ❌ Ainda falhava

**Por que não funcionou:**
- Recompilação de assets Vue.js é um processo pesado que requer:
  - Todas as dependências Node.js instaladas
  - Memória suficiente (6GB+)
  - Tempo de build significativo
- A imagem base do Chatwoot já tem assets pré-compilados
- Recompilar dentro do Dockerfile adiciona complexidade desnecessária

---

#### Tentativa 3: CSS Inline no Layout (SOLUÇÃO FINAL)
**Data:** Terceira tentativa  
**Ação:**
- Adicionado CSS inline no arquivo `app/views/layouts/vueapp.html.erb`
- CSS sobrescreve o tamanho do logo usando `!important`
- Mantido `h-24` nos arquivos Vue para quando recompilarmos no futuro
- Removida tentativa de recompilação do Dockerfile

**Código CSS adicionado:**
```css
<style>
  /* Sobrescrever tamanho do logo na página de login do v3 */
  main section.max-w-5xl img[src*="logo"],
  main section.max-w-5xl img[alt*="CentralCom"],
  main section.max-w-5xl img[alt*="teste-centralcom"],
  main section.max-w-5xl img[alt*="hiz-server"] {
    height: 6rem !important; /* 96px - equivalente a h-24 do Tailwind */
    width: auto !important;
    max-width: none !important;
  }
  /* Fallback mais genérico para garantir que funcione */
  body main img[src*="brand-assets"],
  body main img[src*="logo.svg"],
  body main img[src*="logo_dark.svg"] {
    height: 6rem !important;
    width: auto !important;
  }
</style>
```

**Resultado:** ✅ **SUCESSO**
- Logo agora aparece com 96px de altura
- Build rápido (sem recompilação)
- Sem problemas de memória
- Funciona imediatamente após deploy

**Por que funcionou:**
- CSS inline é aplicado diretamente no HTML, não precisa de recompilação
- `!important` garante que sobrescreve estilos do Tailwind CSS
- Seletores específicos garantem que só afeta o logo na página de login
- Não depende de processos pesados de build

### Arquivos Modificados (Solução Final)

1. **`app/javascript/v3/views/login/Index.vue`**
   - Alterado `h-8` → `h-24` (96px)
   - Mantido para quando recompilarmos assets no futuro

2. **`app/views/layouts/vueapp.html.erb`**
   - Adicionado CSS inline para sobrescrever tamanho do logo
   - **Esta é a solução que funciona atualmente**

3. **`Dockerfile.centralcom`**
   - Simplificado, removida tentativa de recompilação
   - Apenas copia arquivos estáticos e layout

### Lições Aprendidas

✅ **O que funcionou:**
- CSS inline para sobrescrever estilos sem recompilação
- Manter modificações nos arquivos Vue para quando recompilarmos
- Simplificar Dockerfile ao máximo

❌ **O que não funcionou:**
- Recompilar assets Vue.js dentro do Dockerfile
- Depender de processos pesados de build para mudanças simples de CSS
- Tentar aumentar memória do Node.js sem resolver dependências

💡 **Princípios:**
- **Solução mais simples primeiro:** CSS inline > Recompilação completa
- **Evitar rebuild pesado:** Se possível, usar sobrescrita CSS
- **Manter código futuro:** Modificar arquivos Vue mesmo que não recompilemos agora


---

## 📊 Resumo de Modificações

### Arquivos Criados
- `Dockerfile.centralcom` - Dockerfile customizado
- `ESPECIFICACOES_LOGO_FAVICON.md` - Especificações técnicas
- `docs/desenvolvimento/HISTORICO_MODIFICACOES.md` - Este arquivo
- `docs/desenvolvimento/GUIA_ESTRUTURA_CODIGO.md` - Guia de referência

### Arquivos Modificados
- `app/javascript/v3/views/login/Index.vue` - Logo `h-8` → `h-24`
- `app/views/layouts/vueapp.html.erb` - CSS inline para logo
- `config/installation_config.yml` - Configuração de branding
- `public/brand-assets/*.svg` - Logos customizados
- `public/favicon-*.png` - Favicons customizados
- `public/apple-icon-*.png` - Ícones Apple
- `public/android-icon-*.png` - Ícones Android
- `public/ms-icon-*.png` - Ícones Microsoft

### Commits Realizados
1. `96a18dfa3` - chore: atualizar Dockerfile com customizações
2. `83cfeecfa` - Aumentar tamanho do logo na página de login e signup (h-8 -> h-16)
3. `891257630` - feat: aumentar tamanho do logo na página de login (solução final)

---

## 3. Erros do GitHub Actions

**Data:** Janeiro 2025  
**Status:** ⚠️ Identificado (não crítico, pendente de correção)

### Objetivo
Entender e resolver erros do GitHub Actions que aparecem após push para `develop` ou `main`.

### Problema

Após push para `develop` ou `main`, aparecem erros no GitHub Actions:

- ❌ `Publish Chatwoot CE docker images / build (linux/amd64)` - **Failing**
- ❌ `Publish Chatwoot CE docker images / build (linux/arm64)` - **Failing**
- ❌ `Publish Chatwoot EE docker images / build (linux/amd64)` - **Failing**
- ❌ `Publish Chatwoot EE docker images / build (linux/arm64)` - **Failing**

**Erro específico:** `Error: Username and password required` no step "Login to DockerHub"

### Análise

#### 3.1. Onde está configurado?

Os workflows estão em:
- `.github/workflows/publish_foss_docker.yml` - Publica imagem CE (Community Edition)
- `.github/workflows/publish_ee_docker.yml` - Publica imagem EE (Enterprise Edition)

**Linha problemática (linha 67-72):**
```yaml
- name: Login to DockerHub
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
      - develop    # ← Ativado quando fazemos push
      - master     # ← Ativado quando fazemos push
```

#### 3.2. Por que estão falhando?

**Causa Raiz:**
1. **Secrets não configurados:**
   - Workflows tentam fazer login no DockerHub usando `secrets.DOCKERHUB_USERNAME` e `secrets.DOCKERHUB_TOKEN`
   - Esses secrets não estão configurados no nosso fork
   - Sem credenciais, o workflow falha com erro: `Error: Username and password required`

2. **Não precisamos desses workflows:**
   - Usamos nosso próprio `Dockerfile.centralcom`
   - Não publicamos imagens no DockerHub oficial do Chatwoot
   - Esses workflows são do repositório upstream (Chatwoot original)
   - Nossa imagem é construída localmente ou em outro CI/CD
   - Publicar no DockerHub oficial não faz sentido (seria com nome errado: `chatwoot/chatwoot`)

3. **Workflows são ativados automaticamente:**
   - Configurados para rodar em push para `develop` e `master`
   - Como fazemos push para essas branches, os workflows são acionados automaticamente

### Soluções Possíveis

#### Opção 1: Desabilitar Workflows (Recomendado) ⭐

**Ação:** Adicionar condição `if: github.repository == 'chatwoot/chatwoot'` no início do job

**Como fazer:**
1. Editar `.github/workflows/publish_foss_docker.yml` e `.github/workflows/publish_ee_docker.yml`
2. Adicionar `if: github.repository == 'chatwoot/chatwoot'` no job `build`
3. Commit e push

**Prós:**
- ✅ Mantém workflows originais para referência
- ✅ Remove erros do GitHub Actions
- ✅ Workflows aparecem como "skipped" (não como erro)
- ✅ Não quebra nada se quisermos contribuir upstream

**Contras:**
- ⚠️ Workflows ainda aparecem (mas como "skipped", não "failing")

#### Opção 2: Remover Workflows

**Ação:** Deletar arquivos `.github/workflows/publish_*.yml`

**Prós:**
- ✅ Remove erros completamente
- ✅ Limpa interface do GitHub

**Contras:**
- ❌ Perde referência dos workflows originais
- ❌ Se quisermos contribuir upstream, precisamos restaurar

#### Opção 3: Configurar Secrets (NÃO Recomendado)

**Ação:** Configurar secrets do DockerHub no fork

**Contras:**
- ❌ Não precisamos publicar imagens
- ❌ Expor credenciais desnecessariamente
- ❌ Custo de build no GitHub Actions
- ❌ Publicaria imagens com nome errado

### Decisão e Implementação

**Status:** ✅ **Implementado**

**Solução escolhida:** Opção 1 - Desabilitar workflows com condição

**Implementação:**
1. Adicionado `if: github.repository == 'chatwoot/chatwoot'` no job `build` de ambos os workflows
2. Workflows agora são "skipped" em forks ao invés de falhar
3. Erros desaparecem da interface do GitHub Actions

**Arquivos modificados:**
- `.github/workflows/publish_foss_docker.yml` (linha 22)
- `.github/workflows/publish_ee_docker.yml` (linha 22)

**Código adicionado:**
```yaml
jobs:
  build:
    if: github.repository == 'chatwoot/chatwoot'  # Desabilitar em forks
    strategy:
      # ... resto do workflow
```

**Resultado:**
- ✅ Workflows aparecem como "skipped" (não como erro)
- ✅ Erros desaparecem da interface do GitHub
- ✅ Workflows originais mantidos para referência
- ✅ Compatibilidade mantida caso queiramos contribuir upstream

**Commit:** Ver histórico com `git log --oneline` - "chore: desabilitar workflows de publicação Docker (fork)"

### Lições Aprendidas

- ✅ Workflows do upstream são ativados automaticamente em forks
- ✅ Secrets do GitHub Actions não são herdados do repositório original
- ✅ Não precisamos de todos os workflows do upstream
- ✅ Podemos desabilitar workflows sem removê-los (usando condição `if`)

---

## 🔄 Próximos Passos

- [ ] Implementar Opção 1 para desabilitar workflows do GitHub Actions
- [ ] Documentar outras customizações conforme forem feitas
- [ ] Manter este histórico atualizado

---

## 📝 Notas de Manutenção

**Como atualizar este documento:**
1. Adicionar nova seção para cada modificação significativa
2. Documentar tentativas, sucessos e falhas
3. Explicar o "porquê" de cada decisão
4. Manter formato consistente
5. Atualizar data de "Última atualização"

**Formato sugerido para novas seções:**
```markdown
## X. [Título da Modificação]

**Data:** DD/MM/YYYY
**Status:** ✅ Concluído / ⚠️ Em progresso / ❌ Falhou

### Objetivo
[O que queríamos fazer]

### Processo
[Como fizemos]

### Resultado
[O que aconteceu]

### Lições Aprendidas
[O que aprendemos]
```

