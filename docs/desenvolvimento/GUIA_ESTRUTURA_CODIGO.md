# 🗺️ Guia de Estrutura do Código - CentralCom

**Última atualização:** 25/11/2024

Este documento serve como referência rápida para entender a estrutura do código fonte do Chatwoot e onde encontrar arquivos para modificações comuns.

---

## 🎯 Objetivo

Facilitar a navegação e modificação do código fonte, fornecendo:
- Localização de arquivos importantes
- Estrutura de diretórios
- Onde modificar funcionalidades específicas
- Convenções e padrões do projeto

---

## 📋 Índice

1. [Estrutura Geral do Projeto](#1-estrutura-geral-do-projeto)
2. [Frontend (Vue.js)](#2-frontend-vuejs)
3. [Backend (Rails)](#3-backend-rails)
4. [Assets e Estáticos](#4-assets-e-estáticos)
5. [Configurações](#5-configurações)
6. [Docker e Deploy](#6-docker-e-deploy)
7. [Onde Modificar X, Y, Z](#7-onde-modificar-x-y-z)

---

## 1. Estrutura Geral do Projeto

### Diretórios Principais

```
centralcom/
├── app/                    # Código da aplicação (Rails + Vue.js)
│   ├── javascript/         # Frontend Vue.js
│   ├── views/              # Views Rails (ERB)
│   ├── controllers/        # Controllers Rails
│   ├── models/             # Models Rails
│   └── services/           # Services Rails
├── config/                 # Configurações
├── db/                     # Migrations e seeds
├── public/                 # Arquivos estáticos
├── spec/                   # Testes RSpec
├── docker/                 # Dockerfiles originais
├── .github/                # GitHub Actions workflows
└── Dockerfile.centralcom   # Nosso Dockerfile customizado
```

---

## 2. Frontend (Vue.js)

### Estrutura do Frontend

```
app/javascript/
├── v3/                     # Versão 3 do frontend (atual)
│   ├── views/              # Páginas/Views
│   │   ├── login/          # Página de login
│   │   ├── auth/           # Autenticação (signup, etc)
│   │   ├── dashboard/      # Dashboard principal
│   │   └── onboarding/     # Onboarding
│   ├── components/         # Componentes reutilizáveis
│   ├── store/              # Vuex store (estado global)
│   ├── router/             # Rotas Vue Router
│   └── mixins/             # Mixins Vue
├── shared/                 # Código compartilhado
└── dashboard/              # Versão antiga (legacy)
```

### Onde Modificar...

#### **Página de Login (Usuário)**
- **Arquivo:** `app/javascript/v3/views/login/Index.vue`
- **O que contém:**
  - Template HTML da página
  - Lógica de autenticação
  - Logo e branding
- **Exemplo de modificação:** Tamanho do logo (`h-8`, `h-16`, `h-24`)
- **CSS override:** `app/views/layouts/vueapp.html.erb` (CSS inline no `<head>`)

#### **Página de Login do Super Admin**
- **Arquivo:** `app/views/super_admin/devise/sessions/new.html.erb`
- **O que contém:**
  - Template ERB completo (não usa Vue.js)
  - Formulário de login do Super Admin
  - Logo e branding
- **Exemplo de modificação:** Tamanho do logo (`h-8` → `h-24`)
- **CSS override:** CSS inline no próprio arquivo `<head>` (não usa layout compartilhado)
- **Importante:** Este arquivo é copiado pelo `Dockerfile.centralcom` separadamente

#### **Página de Signup**
- **Arquivo:** `app/javascript/v3/views/auth/signup/Index.vue`
- **Similar ao login, mas para registro**

#### **Dashboard Principal**
- **Arquivo:** `app/javascript/v3/views/dashboard/Index.vue`
- **Componentes relacionados:** `app/javascript/v3/components/`

#### **Sidebar/Navegação**
- **Arquivo:** `app/javascript/v3/components/sidebar/`
- **Logo do sidebar:** Provavelmente em componente de header/navbar

#### **Componentes Reutilizáveis**
- **Localização:** `app/javascript/v3/components/`
- **Exemplos:**
  - Botões: `app/javascript/v3/components/Button/`
  - Formulários: `app/javascript/v3/components/Form/`
  - Modais: `app/javascript/v3/components/Modal/`

#### **Estilos (CSS/Tailwind)**
- **Configuração Tailwind:** `tailwind.config.js`
- **CSS global:** `app/javascript/v3/assets/` (se existir)
- **CSS inline:** `app/views/layouts/vueapp.html.erb` (layout principal)

#### **Estado Global (Vuex)**
- **Store:** `app/javascript/v3/store/`
- **Módulos:** Cada funcionalidade tem seu módulo
- **Configuração global:** `app/javascript/v3/store/modules/globalConfig/`

---

## 3. Backend (Rails)

### Estrutura do Backend

```
app/
├── controllers/            # Controllers Rails
│   ├── api/                # API REST
│   └── v1/                 # Versão 1 da API
├── models/                 # Models ActiveRecord
├── services/               # Services (lógica de negócio)
├── workers/                # Background jobs (Sidekiq)
├── views/                  # Views Rails (ERB)
│   └── layouts/            # Layouts principais
└── mailers/                # Email templates
```

### Onde Modificar...

#### **API REST**
- **Controllers:** `app/controllers/api/v1/`
- **Exemplo:** `app/controllers/api/v1/accounts/conversations_controller.rb`
- **Rotas:** `config/routes.rb`

#### **Models**
- **Localização:** `app/models/`
- **Exemplos:**
  - `app/models/account.rb`
  - `app/models/conversation.rb`
  - `app/models/message.rb`

#### **Services (Lógica de Negócio)**
- **Localização:** `app/services/`
- **Exemplo:** `app/services/conversation_reply_service.rb`

#### **Background Jobs**
- **Localização:** `app/workers/`
- **Exemplo:** `app/workers/conversation_reply_email_worker.rb`

#### **Layouts Rails**
- **Layout principal Vue.js:** `app/views/layouts/vueapp.html.erb`
- **Layouts outros:** `app/views/layouts/`

---

## 4. Assets e Estáticos

### Estrutura de Assets

```
public/
├── brand-assets/           # Logos e branding
│   ├── logo.svg            # Logo modo claro
│   ├── logo_dark.svg       # Logo modo escuro
│   └── logo_thumbnail.svg  # Logo miniatura
├── favicon-*.png           # Favicons (múltiplos tamanhos)
├── apple-icon-*.png        # Ícones Apple
├── android-icon-*.png      # Ícones Android
└── ms-icon-*.png           # Ícones Microsoft
```

### Onde Modificar...

#### **Logos**
- **Localização:** `public/brand-assets/`
- **Arquivos:**
  - `logo.svg` - Logo principal (modo claro)
  - `logo_dark.svg` - Logo modo escuro
  - `logo_thumbnail.svg` - Logo miniatura (usado em notificações, etc)
- **📚 Especificações detalhadas:** Ver [`ESPECIFICACOES_LOGO_FAVICON.md`](../../ESPECIFICACOES_LOGO_FAVICON.md) na raiz do repositório

#### **Favicons**
- **Localização:** `public/favicon-*.png`
- **Tamanhos:** 16x16, 32x32, 96x96, 512x512

#### **Ícones Apple (iOS)**
- **Localização:** `public/apple-icon-*.png`
- **Tamanhos:** 57x57, 60x60, 72x72, 76x76, 114x114, 120x120, 144x144, 152x152, 180x180

#### **Ícones Android**
- **Localização:** `public/android-icon-*.png`
- **Tamanhos:** 36x36, 48x48, 72x72, 96x96, 144x144, 192x192

#### **Ícones Microsoft (Windows)**
- **Localização:** `public/ms-icon-*.png`
- **Tamanhos:** 70x70, 144x144, 150x150, 310x310

---

## 5. Configurações

### Arquivos de Configuração

```
config/
├── installation_config.yml # Configuração de instalação (branding, nome, etc)
├── database.yml            # Configuração do banco de dados
├── routes.rb               # Rotas Rails
├── application.rb          # Configuração principal Rails
└── environments/           # Config por ambiente (dev, prod, test)
```

### Onde Modificar...

#### **Branding e Nome da Instalação**
- **Arquivo:** `config/installation_config.yml`
- **O que contém:**
  - Nome da instalação
  - Caminhos dos logos
  - Configurações de branding
- **Exemplo:**
  ```yaml
  installation:
    name: "CentralCom"
    logo:
      light: "/brand-assets/logo.svg"
      dark: "/brand-assets/logo_dark.svg"
  ```

#### **Rotas**
- **Arquivo:** `config/routes.rb`
- **Onde adicionar novas rotas da API ou páginas**

#### **Configuração do Banco de Dados**
- **Arquivo:** `config/database.yml`
- **⚠️ Cuidado:** Geralmente configurado via variáveis de ambiente

#### **Variáveis de Ambiente**
- **Arquivo:** `.env` (não versionado) ou `config/environments/`
- **Documentação:** Ver README.md ou documentação do Chatwoot

#### **⚠️ Tabela installation_configs (PostgreSQL)**
- **Localização:** Banco de dados PostgreSQL, tabela `installation_configs`
- **O que contém:**
  - Configurações de instalação (INSTALLATION_NAME, BRAND_NAME, etc)
  - Valores são serializados em formato YAML Ruby
  - **⚠️ IMPORTANTE:** Valores do banco **sobrescrevem** variáveis de ambiente!
- **Por que é importante:**
  - Variáveis de ambiente só funcionam na **primeira inicialização** com banco vazio
  - Bancos existentes usam valores salvos na tabela, ignorando variáveis de ambiente
  - Para mudar configurações em instalação existente, é necessário atualizar diretamente no banco
- **Formato do valor:**
  ```yaml
  --- !ruby/hash:ActiveSupport::HashWithIndifferentAccess
  value: CentralCom
  ```
- **Como consultar:**
  ```sql
  SELECT name, serialized_value FROM installation_configs 
  WHERE name IN ('INSTALLATION_NAME', 'BRAND_NAME');
  ```
- **Como atualizar:**
  ```sql
  UPDATE installation_configs 
  SET serialized_value = '--- !ruby/hash:ActiveSupport::HashWithIndifferentAccess
  value: NovoValor
  ' 
  WHERE name = 'INSTALLATION_NAME';
  ```
- **📚 Ver também:** [`FAQ.md`](/root/FAQ.md) - Seção "INSTALLATION_NAME NÃO FUNCIONA"

---

## 6. Docker e Deploy

### Arquivos Docker

```
centralcom/
├── Dockerfile.centralcom   # Nosso Dockerfile customizado
├── docker/                 # Dockerfiles originais do Chatwoot
│   └── Dockerfile          # Dockerfile oficial
├── docker-compose.yaml     # Docker Compose para desenvolvimento
└── docker-compose.production.yaml  # Docker Compose produção
```

### Onde Modificar...

#### **Dockerfile Customizado**
- **Arquivo:** `Dockerfile.centralcom`
- **O que faz:**
  - Baseia-se em `chatwoot/chatwoot:v4.1.0`
  - Copia assets customizados (logos, favicons)
  - Copia configurações customizadas (`installation_config.yml`)
  - Copia layouts customizados (`vueapp.html.erb`)
  - Copia página de login do Super Admin (`super_admin/devise/sessions/new.html.erb`)
  - **⚠️ Não recompila assets Vue.js** (usa CSS inline)
  - **Importante:** Sempre adicionar `COPY` para novos arquivos que modificar

#### **Docker Compose (Produção)**
- **Arquivo:** `docker-compose.production.yaml`
- **Onde configurar:** Serviços, volumes, networks

---

## 7. Onde Modificar X, Y, Z

### 🎨 **Modificar Logo/Tamanho do Logo**

1. **Logo SVG:**
   - Arquivo: `public/brand-assets/logo.svg` ou `logo_dark.svg`
   - Substituir o arquivo SVG

2. **Tamanho do Logo nas Páginas de Login:**
   
   **Página de Login (Usuário):**
   - Arquivo Vue: `app/javascript/v3/views/login/Index.vue`
   - Alterar classe Tailwind: `h-8` → `h-16` ou `h-24`
   - **CSS Override:** Adicionar CSS inline em `app/views/layouts/vueapp.html.erb` (no `<head>`)
   - **Por quê:** Evita recompilação de assets Vue.js (que consome muita memória)
   
   **Página de Login do Super Admin:**
   - Arquivo ERB: `app/views/super_admin/devise/sessions/new.html.erb`
   - Alterar classe Tailwind: `h-8` → `h-24` nas tags `<img>`
   - **CSS Override:** Adicionar CSS inline no próprio arquivo (no `<head>`)
   - **Importante:** Este arquivo deve ser copiado pelo `Dockerfile.centralcom`
   - **Exemplo de CSS:**
     ```css
     <style>
       main section.max-w-5xl img[src*="logo"],
       main section.max-w-5xl img[src*="brand-assets"] {
         height: 6rem !important; /* 96px */
         width: auto !important;
       }
     </style>
     ```

3. **Logo no Sidebar/Dashboard:**
   - Provavelmente em: `app/javascript/v3/components/sidebar/` ou similar
   - Buscar por `globalConfig.logo` no código

---

### 🔐 **Modificar Autenticação/Login**

1. **Página de Login:**
   - Arquivo: `app/javascript/v3/views/login/Index.vue`
   - Componente de formulário: `app/javascript/v3/views/login/components/`

2. **Lógica de Autenticação:**
   - Backend: `app/controllers/api/v1/auth/` ou similar
   - Services: `app/services/` (buscar por "auth" ou "login")

3. **Validações:**
   - Models: `app/models/user.rb` ou similar
   - Validators: `app/validators/` (se existir)

---

### 💬 **Modificar Chat/Mensagens**

1. **Interface do Chat:**
   - Componentes: `app/javascript/v3/components/conversation/` ou similar
   - Views: `app/javascript/v3/views/conversation/`

2. **API de Mensagens:**
   - Controller: `app/controllers/api/v1/accounts/conversations_controller.rb`
   - Model: `app/models/message.rb`

3. **WebSocket (Real-time):**
   - ActionCable: `app/channels/` (Rails)
   - Frontend: `app/javascript/v3/store/modules/conversation/` ou similar

---

### 📧 **Modificar Emails**

1. **Templates de Email:**
   - Localização: `app/views/mailers/` ou `app/views/user_mailer/`
   - Formato: ERB (HTML + Ruby)

2. **Envio de Emails:**
   - Mailers: `app/mailers/`
   - Workers: `app/workers/` (buscar por "email")

---

### 🎨 **Modificar Estilos/CSS**

1. **Tailwind CSS:**
   - Config: `tailwind.config.js`
   - Classes: Usar diretamente nos componentes Vue

2. **CSS Global:**
   - Layout: `app/views/layouts/vueapp.html.erb` (CSS inline)
   - Ou: `app/javascript/v3/assets/` (se existir)

3. **Temas/Cores:**
   - Tailwind config: `tailwind.config.js`
   - Variáveis CSS: Buscar por `--color-` ou similar

---

### 🔔 **Modificar Notificações**

1. **Notificações Frontend:**
   - Componentes: `app/javascript/v3/components/notifications/` ou similar
   - Store: `app/javascript/v3/store/modules/notifications/`

2. **Notificações Backend:**
   - Services: `app/services/` (buscar por "notification")
   - Workers: `app/workers/` (buscar por "notification")

---

### 📊 **Modificar Dashboard/Relatórios**

1. **Dashboard Principal:**
   - View: `app/javascript/v3/views/dashboard/Index.vue`
   - Componentes: `app/javascript/v3/components/dashboard/`

2. **API de Dados:**
   - Controllers: `app/controllers/api/v1/accounts/reports/` ou similar
   - Services: `app/services/` (buscar por "report" ou "analytics")

---

### 🔧 **Adicionar Nova Funcionalidade**

1. **Frontend:**
   - Criar componente: `app/javascript/v3/components/[nome]/`
   - Criar view: `app/javascript/v3/views/[nome]/`
   - Adicionar rota: `app/javascript/v3/router/index.js`

2. **Backend:**
   - Criar controller: `app/controllers/api/v1/[nome]_controller.rb`
   - Criar model: `app/models/[nome].rb`
   - Criar service: `app/services/[nome]_service.rb`
   - Adicionar rota: `config/routes.rb`

3. **Database:**
   - Criar migration: `db/migrate/YYYYMMDDHHMMSS_create_[nome].rb`

---

## 🔍 Dicas de Busca

### Como Encontrar Arquivos Rapidamente

1. **Buscar por texto no código:**
   ```bash
   grep -r "texto_a_buscar" app/
   ```

2. **Buscar por componente Vue:**
   - Nome do componente → `app/javascript/v3/components/[Nome]/`

3. **Buscar por rota:**
   - URL → `config/routes.rb` → Controller correspondente

4. **Buscar por funcionalidade:**
   - Nome da feature → `app/services/` ou `app/javascript/v3/`

---

## 📚 Recursos Adicionais

- **Documentação Chatwoot:** https://www.chatwoot.com/docs
- **Repositório Original:** https://github.com/chatwoot/chatwoot
- **Especificações Logo/Favicon:** `ESPECIFICACOES_LOGO_FAVICON.md`
- **Histórico de Modificações:** `docs/desenvolvimento/HISTORICO_MODIFICACOES.md`

---

## 🔄 Manutenção deste Documento

**Como atualizar:**
1. Adicionar novas seções conforme descobrimos novos locais
2. Atualizar caminhos se estrutura mudar
3. Adicionar exemplos práticos de modificações
4. Manter formato consistente

**Formato sugerido para novas seções:**
```markdown
### 🔧 **Modificar [Funcionalidade]**

1. **Onde encontrar:**
   - Arquivo: `caminho/para/arquivo`
   - O que contém: [descrição]

2. **Como modificar:**
   - Passo 1: [ação]
   - Passo 2: [ação]
```

---

**Última atualização:** 25/11/2024
