# 🚀 Plano de Desenvolvimento de Features - CentralCom

**Data de criação:** 15/01/2025  
**Status:** 📋 Planejamento

Este documento contém o planejamento detalhado para desenvolvimento das novas features e melhorias no CentralCom.

---

## 📋 Índice

1. [Análise: Enterprise vs Módulo Próprio](#1-análise-enterprise-vs-módulo-próprio)
2. [Sistema de Notificações](#2-sistema-de-notificações)
3. [Notificações de Marcações no WhatsApp](#3-notificações-de-marcações-no-whatsapp)
4. [Módulo de Comunicação Interna](#4-módulo-de-comunicação-interna)
5. [Melhorias de Interface](#5-melhorias-de-interface)
6. [Sistema de Permissões](#6-sistema-de-permissões)
7. [Estratégia de Desenvolvimento](#7-estratégia-de-desenvolvimento)

---

## 1. Análise: Enterprise vs Módulo Próprio

### ✅ **Recomendação: USAR O ENTERPRISE EXISTENTE**

**Motivos:**

1. **Enterprise já está no código:**
   - Pasta `enterprise/` existe e está funcional
   - `ChatwootApp.enterprise?` retorna `true` se a pasta existir
   - Funcionalidades Enterprise já estão implementadas

2. **Sistema de Permissões já existe:**
   - `CustomRole` model em `enterprise/app/models/custom_role.rb`
   - `PermissionFilterService` em `enterprise/app/services/enterprise/conversations/permission_filter_service.rb`
   - Controller: `enterprise/app/controllers/api/v1/accounts/custom_roles_controller.rb`
   - Permissões granulares já implementadas

3. **Vantagens de usar Enterprise:**
   - ✅ Não precisa recriar do zero
   - ✅ Sistema testado e funcional
   - ✅ Compatível com atualizações futuras do Chatwoot
   - ✅ Estrutura modular (não quebra código existente)
   - ✅ Pode estender funcionalidades existentes

4. **Como ativar:**
   - A pasta `enterprise/` já existe → Enterprise já está ativo!
   - Verificar se `ENV['DISABLE_ENTERPRISE']` não está setado
   - Verificar se `ChatwootApp.enterprise?` retorna `true`

### 🔍 **Verificação Necessária:**

```ruby
# Verificar se Enterprise está ativo
ChatwootApp.enterprise?  # Deve retornar true

# Verificar variável de ambiente
ENV['DISABLE_ENTERPRISE']  # Deve ser nil ou false
```

### 📝 **Próximos Passos:**

1. ✅ Verificar se Enterprise está funcionando
2. ✅ Testar sistema de permissões existente
3. ✅ Estender funcionalidades conforme necessário
4. ✅ Customizar interface de permissões se necessário

---

## 2. Sistema de Notificações

### 🎯 **Objetivo:**
Melhorar sistema de notificações visual e sonoramente.

### 📍 **Onde Está Implementado:**

#### **Frontend:**
- **Widget (SDK):** `app/javascript/widget/App.vue`
  - Método: `handleUnreadNotificationDot()`
  - Classes CSS: `unread-notification`
- **SDK:** `app/javascript/sdk/IFrameHelper.js`
  - Handler: `handleNotificationDot`
- **Store:** `app/javascript/dashboard/store/mutation-types.js`
  - `SET_NOTIFICATIONS_META`
  - `SET_NOTIFICATIONS_UNREAD_COUNT`

#### **Backend:**
- **ActionCable:** `app/channels/` (WebSocket para real-time)
- **Workers:** `app/workers/` (buscar por "notification")

### 🔧 **Onde Modificar:**

#### **2.1. Notificações Visuais**

**Arquivos principais:**
- `app/javascript/v3/components/notifications/` (se existir)
- `app/javascript/dashboard/store/modules/notifications/` (se existir)
- `app/javascript/v3/store/modules/notifications/` (se existir)

**O que melhorar:**
1. **Badge de notificações:**
   - Tamanho, cor, animação
   - Posicionamento
   - Contador de não lidas

2. **Toast/Alert de notificações:**
   - Estilo visual
   - Duração de exibição
   - Posição na tela
   - Tipos diferentes (info, success, warning, error)

3. **Lista de notificações:**
   - Design da lista
   - Agrupamento por tipo/data
   - Ações rápidas

**Buscar arquivos:**
```bash
find app/javascript -name "*notification*" -type f
find app/javascript -name "*toast*" -type f
find app/javascript -name "*alert*" -type f
```

#### **2.2. Notificações Sonoras**

**Arquivos principais:**
- `app/javascript/shared/helpers/AudioNotificationHelper.js` (mencionado em `IFrameHelper.js`)

**O que melhorar:**
1. **Sons diferentes por tipo:**
   - Nova mensagem
   - Nova conversa
   - Marcação mencionada
   - Atribuição de conversa

2. **Configurações de volume:**
   - Controle de volume por tipo
   - Mute/Unmute
   - Horário de silenciar (ex: após 22h)

3. **Permissões do navegador:**
   - Solicitar permissão de áudio
   - Fallback se bloqueado

### 📝 **Plano de Implementação:**

1. **Fase 1: Mapear estrutura atual**
   - [ ] Encontrar todos os arquivos de notificação
   - [ ] Entender fluxo atual
   - [ ] Identificar pontos de extensão

2. **Fase 2: Melhorias visuais**
   - [ ] Criar/atualizar componente de notificação visual
   - [ ] Adicionar animações
   - [ ] Melhorar design do badge
   - [ ] Criar sistema de toast/alert

3. **Fase 3: Melhorias sonoras**
   - [ ] Adicionar sons diferentes por tipo
   - [ ] Criar configurações de volume
   - [ ] Implementar controle de mute
   - [ ] Adicionar permissões do navegador

4. **Fase 4: Testes**
   - [ ] Testar em diferentes navegadores
   - [ ] Testar permissões
   - [ ] Testar performance

---

## 3. Notificações de Marcações no WhatsApp

### 🎯 **Objetivo:**
Notificar quando alguém é marcado (@mention) em mensagens do WhatsApp, além de mensagens e conversas criadas.

### 📍 **Onde Está Implementado:**

#### **Backend:**
- **Evolution API:** Integração com WhatsApp
- **Mensagens:** `app/models/message.rb`
- **Mentions:** Provavelmente em `app/services/` ou `app/models/`

### 🔍 **Buscar Implementação Atual:**

```bash
# Buscar por mentions/menções
grep -r "mention\|@mention\|@\w" app/models app/services app/controllers

# Buscar por marcações no WhatsApp
grep -r "whatsapp\|evolution" app/models app/services | grep -i mention
```

### 🔧 **Onde Implementar:**

#### **3.1. Backend - Detectar Marcações**

**Arquivos a criar/modificar:**
- `app/services/message_mention_service.rb` (novo)
- `app/models/message.rb` (adicionar método `extract_mentions`)
- `app/workers/mention_notification_worker.rb` (novo)

**Lógica:**
1. Ao receber mensagem do WhatsApp via Evolution API
2. Extrair menções do texto (ex: `@Bruno`, `@usuário`)
3. Identificar usuários mencionados
4. Criar notificação para cada usuário mencionado

#### **3.2. Frontend - Exibir Notificações**

**Arquivos a criar/modificar:**
- `app/javascript/v3/components/notifications/MentionNotification.vue` (novo)
- `app/javascript/v3/store/modules/notifications/` (adicionar action para mentions)

**Lógica:**
1. Receber notificação via WebSocket (ActionCable)
2. Exibir notificação visual
3. Tocar som específico para menção
4. Redirecionar para mensagem quando clicado

#### **3.3. Evolution API - Webhook**

**Verificar:**
- Como Evolution API envia mensagens
- Se já há webhook configurado
- Onde processar mensagens recebidas

**Arquivos:**
- `app/controllers/api/v1/integrations/evolution/` (se existir)
- `app/services/integrations/evolution/` (se existir)

### 📝 **Plano de Implementação:**

1. **Fase 1: Análise**
   - [ ] Verificar como Evolution API envia mensagens
   - [ ] Verificar se já existe sistema de mentions
   - [ ] Mapear fluxo de mensagens

2. **Fase 2: Backend**
   - [ ] Criar service para extrair mentions
   - [ ] Criar worker para enviar notificações
   - [ ] Integrar com ActionCable
   - [ ] Adicionar endpoint para mentions (se necessário)

3. **Fase 3: Frontend**
   - [ ] Criar componente de notificação de mention
   - [ ] Adicionar som específico
   - [ ] Integrar com store de notificações
   - [ ] Adicionar link para mensagem

4. **Fase 4: Testes**
   - [ ] Testar detecção de mentions
   - [ ] Testar notificações
   - [ ] Testar diferentes formatos de mention

---

## 4. Módulo de Comunicação Interna

### 🎯 **Objetivo:**
Criar um módulo para comunicação interna entre agentes (chat interno, mensagens diretas, etc).

### 📍 **Estrutura Sugerida:**

#### **4.1. Backend**

**Models:**
- `app/models/internal_message.rb` (novo)
- `app/models/internal_conversation.rb` (novo)

**Controllers:**
- `app/controllers/api/v1/internal_messages_controller.rb` (novo)
- `app/controllers/api/v1/internal_conversations_controller.rb` (novo)

**Services:**
- `app/services/internal_message_service.rb` (novo)
- `app/services/internal_conversation_service.rb` (novo)

**Workers:**
- `app/workers/internal_message_notification_worker.rb` (novo)

**Channels (ActionCable):**
- `app/channels/internal_messages_channel.rb` (novo)

#### **4.2. Frontend**

**Views:**
- `app/javascript/v3/views/internal/Index.vue` (nova)
- `app/javascript/v3/views/internal/Conversation.vue` (nova)

**Components:**
- `app/javascript/v3/components/internal/MessageList.vue` (novo)
- `app/javascript/v3/components/internal/MessageInput.vue` (novo)
- `app/javascript/v3/components/internal/ConversationList.vue` (novo)

**Store:**
- `app/javascript/v3/store/modules/internal/` (novo)
  - `messages.js`
  - `conversations.js`

**Router:**
- Adicionar rota em `app/javascript/v3/router/index.js`

### 🔧 **Funcionalidades:**

1. **Lista de conversas internas:**
   - Conversas com outros agentes
   - Indicador de não lidas
   - Última mensagem
   - Timestamp

2. **Chat interno:**
   - Enviar mensagens
   - Receber mensagens em tempo real (WebSocket)
   - Indicador de digitação
   - Status de leitura

3. **Notificações:**
   - Notificar quando receber mensagem interna
   - Som específico
   - Badge de não lidas

4. **Integração:**
   - Botão no sidebar
   - Acesso rápido
   - Indicador de novas mensagens

### 📝 **Plano de Implementação:**

1. **Fase 1: Backend - Models e Migrations**
   - [ ] Criar migration para `internal_conversations`
   - [ ] Criar migration para `internal_messages`
   - [ ] Criar models
   - [ ] Criar associations

2. **Fase 2: Backend - API**
   - [ ] Criar controllers
   - [ ] Criar services
   - [ ] Criar rotas
   - [ ] Criar policies (autorização)

3. **Fase 3: Backend - Real-time**
   - [ ] Criar ActionCable channel
   - [ ] Implementar broadcast de mensagens
   - [ ] Implementar indicador de digitação

4. **Fase 4: Frontend - Interface**
   - [ ] Criar views
   - [ ] Criar components
   - [ ] Criar store
   - [ ] Adicionar rotas

5. **Fase 5: Integração**
   - [ ] Adicionar no sidebar
   - [ ] Integrar notificações
   - [ ] Adicionar indicadores

6. **Fase 6: Testes**
   - [ ] Testar envio/recebimento
   - [ ] Testar real-time
   - [ ] Testar notificações

---

## 5. Melhorias de Interface

### 🎯 **Objetivo:**
Deixar a interface mais intuitiva para os agentes, remover excessos.

### 📍 **Onde Modificar:**

#### **5.1. Sidebar/Navegação**

**Arquivos:**
- `app/javascript/v3/components/sidebar/` (se existir)
- `app/javascript/v3/components/navigation/` (se existir)

**O que fazer:**
- Remover itens desnecessários
- Reorganizar menu
- Simplificar navegação
- Adicionar atalhos úteis

#### **5.2. Dashboard**

**Arquivos:**
- `app/javascript/v3/views/dashboard/Index.vue`
- `app/javascript/v3/components/dashboard/`

**O que fazer:**
- Simplificar widgets
- Remover informações desnecessárias
- Focar no essencial para agentes
- Melhorar layout

#### **5.3. Chat/Conversa**

**Arquivos:**
- `app/javascript/v3/components/conversation/`
- `app/javascript/v3/views/conversation/`

**O que fazer:**
- Simplificar interface do chat
- Remover botões/ações pouco usados
- Melhorar organização de informações
- Otimizar espaço

#### **5.4. Formulários**

**Arquivos:**
- `app/javascript/v3/components/Form/`
- Formulários em várias views

**O que fazer:**
- Simplificar campos
- Melhorar UX
- Adicionar validações visuais
- Reduzir cliques

### 🔍 **Como Identificar Excessos:**

1. **Análise de uso:**
   - Verificar quais funcionalidades são mais usadas
   - Identificar funcionalidades pouco usadas
   - Entrevistar agentes sobre dificuldades

2. **Análise visual:**
   - Identificar elementos que ocupam muito espaço
   - Verificar informações redundantes
   - Simplificar hierarquia visual

3. **Testes de usabilidade:**
   - Observar agentes usando o sistema
   - Identificar pontos de confusão
   - Coletar feedback

### 📝 **Plano de Implementação:**

1. **Fase 1: Análise**
   - [ ] Mapear todas as telas principais
   - [ ] Identificar elementos desnecessários
   - [ ] Coletar feedback dos agentes
   - [ ] Priorizar melhorias

2. **Fase 2: Sidebar/Navegação**
   - [ ] Simplificar menu
   - [ ] Reorganizar itens
   - [ ] Remover itens pouco usados
   - [ ] Adicionar atalhos úteis

3. **Fase 3: Dashboard**
   - [ ] Simplificar widgets
   - [ ] Remover informações desnecessárias
   - [ ] Melhorar layout
   - [ ] Focar no essencial

4. **Fase 4: Chat/Conversa**
   - [ ] Simplificar interface
   - [ ] Remover ações pouco usadas
   - [ ] Melhorar organização
   - [ ] Otimizar espaço

5. **Fase 5: Testes**
   - [ ] Testar com agentes reais
   - [ ] Coletar feedback
   - [ ] Ajustar conforme necessário

---

## 6. Sistema de Permissões

### 🎯 **Objetivo:**
Melhorar sistema de permissões (usar Enterprise existente e estender conforme necessário).

### 📍 **Onde Está Implementado:**

#### **Backend:**
- **Model:** `enterprise/app/models/custom_role.rb`
- **Controller:** `enterprise/app/controllers/api/v1/accounts/custom_roles_controller.rb`
- **Service:** `enterprise/app/services/enterprise/conversations/permission_filter_service.rb`
- **Policy:** `enterprise/app/policies/custom_role_policy.rb`

#### **Frontend:**
- Buscar em `app/javascript/v3/` por "role", "permission", "custom_role"

### 🔍 **Verificar Implementação Atual:**

```bash
# Buscar frontend de permissões
find app/javascript -name "*role*" -o -name "*permission*" -type f

# Verificar models
cat enterprise/app/models/custom_role.rb

# Verificar controller
cat enterprise/app/controllers/api/v1/accounts/custom_roles_controller.rb
```

### 🔧 **O que Melhorar:**

#### **6.1. Interface de Gerenciamento**

**O que criar/modificar:**
- Interface para criar/editar roles
- Interface para atribuir roles a usuários
- Visualização de permissões
- Teste de permissões

#### **6.2. Novas Permissões**

**Permissões sugeridas:**
- `internal_message_send` - Enviar mensagens internas
- `internal_message_read` - Ler mensagens internas
- `mention_notify` - Receber notificações de menções
- `notification_configure` - Configurar notificações
- `dashboard_customize` - Personalizar dashboard
- `report_view` - Ver relatórios
- `report_export` - Exportar relatórios

#### **6.3. Granularidade**

**Melhorar:**
- Permissões mais granulares
- Permissões por inbox/canal
- Permissões por tipo de conversa
- Permissões temporárias

### 📝 **Plano de Implementação:**

1. **Fase 1: Análise do Sistema Atual**
   - [ ] Verificar se Enterprise está ativo
   - [ ] Testar sistema de permissões existente
   - [ ] Mapear permissões disponíveis
   - [ ] Verificar interface frontend

2. **Fase 2: Melhorar Interface**
   - [ ] Criar/atualizar interface de gerenciamento
   - [ ] Melhorar UX
   - [ ] Adicionar visualização de permissões
   - [ ] Adicionar testes de permissões

3. **Fase 3: Adicionar Novas Permissões**
   - [ ] Definir novas permissões necessárias
   - [ ] Adicionar no backend
   - [ ] Adicionar validações
   - [ ] Adicionar no frontend

4. **Fase 4: Granularidade**
   - [ ] Implementar permissões por inbox
   - [ ] Implementar permissões por tipo
   - [ ] Implementar permissões temporárias (se necessário)

5. **Fase 5: Testes**
   - [ ] Testar criação de roles
   - [ ] Testar atribuição de roles
   - [ ] Testar validação de permissões
   - [ ] Testar interface

---

## 7. Estratégia de Desenvolvimento

### 🎯 **Princípios:**

1. **Não quebrar o que funciona:**
   - Sempre testar em ambiente de staging primeiro
   - Fazer backup antes de mudanças grandes
   - Manter compatibilidade com código existente

2. **Desenvolvimento incremental:**
   - Uma feature por vez
   - Testar cada etapa
   - Documentar cada modificação

3. **Modularidade:**
   - Criar módulos separados quando possível
   - Usar concerns/services para lógica complexa
   - Manter código organizado

4. **Documentação:**
   - Documentar em `HISTORICO_MODIFICACOES.md`
   - Atualizar `GUIA_ESTRUTURA_CODIGO.md`
   - Comentar código complexo

### 📋 **Ordem Recomendada de Desenvolvimento:**

1. **Sistema de Permissões** (usar Enterprise existente)
   - Base para outras features
   - Já existe, só precisa melhorar

2. **Sistema de Notificações** (melhorias visuais e sonoras)
   - Base para outras notificações
   - Impacto imediato na UX

3. **Notificações de Marcações**
   - Depende do sistema de notificações
   - Funcionalidade específica

4. **Módulo de Comunicação Interna**
   - Feature independente
   - Pode usar sistema de permissões

5. **Melhorias de Interface**
   - Contínuo durante todo o desenvolvimento
   - Ajustar conforme feedback

### 🔄 **Workflow de Desenvolvimento:**

1. **Criar branch:**
   ```bash
   git checkout -b feature/nome-da-feature
   ```

2. **Desenvolver:**
   - Fazer modificações
   - Testar localmente
   - Commitar incrementalmente

3. **Documentar:**
   - Atualizar `HISTORICO_MODIFICACOES.md`
   - Atualizar `GUIA_ESTRUTURA_CODIGO.md` se necessário

4. **Testar em staging:**
   - Fazer merge para `develop`
   - Testar em ambiente de staging
   - Corrigir problemas

5. **Deploy em produção:**
   - Fazer merge para `main`
   - Deploy em produção
   - Monitorar

### ⚠️ **Cuidados Importantes:**

1. **Backup:**
   - Sempre fazer backup antes de mudanças grandes
   - Testar rollback se necessário

2. **Staging:**
   - Sempre testar em staging primeiro
   - Usar ambiente de teste (Chatwoot Teste)

3. **Compatibilidade:**
   - Não quebrar funcionalidades existentes
   - Manter compatibilidade com dados existentes
   - Considerar migrations se necessário

4. **Performance:**
   - Monitorar impacto de novas features
   - Otimizar queries se necessário
   - Considerar cache quando apropriado

5. **Segurança:**
   - Validar permissões
   - Sanitizar inputs
   - Proteger endpoints

---

## 📝 Próximos Passos Imediatos

### 1. Verificar Enterprise
- [ ] Verificar se `ChatwootApp.enterprise?` retorna `true`
- [ ] Testar sistema de permissões existente
- [ ] Verificar interface de permissões no frontend

### 2. Mapear Estrutura de Notificações
- [ ] Encontrar todos os arquivos de notificação
- [ ] Entender fluxo atual
- [ ] Identificar pontos de extensão

### 3. Mapear Evolution API
- [ ] Verificar como Evolution API envia mensagens
- [ ] Verificar webhooks configurados
- [ ] Entender estrutura de mensagens

### 4. Planejar Interface
- [ ] Mapear telas principais
- [ ] Identificar elementos desnecessários
- [ ] Coletar feedback dos agentes

---

## 🔗 Referências

- **Guia de Estrutura:** [`GUIA_ESTRUTURA_CODIGO.md`](./GUIA_ESTRUTURA_CODIGO.md)
- **Histórico de Modificações:** [`HISTORICO_MODIFICACOES.md`](./HISTORICO_MODIFICACOES.md)
- **Documentação Chatwoot:** https://www.chatwoot.com/docs
- **Repositório Original:** https://github.com/chatwoot/chatwoot

---

**Última atualização:** 15/01/2025

