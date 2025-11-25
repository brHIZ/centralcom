# 🚀 Plano de Deploy para Produção - CentralCom

**Última atualização:** 15/01/2025

Este documento descreve o processo seguro de deploy da versão customizada do CentralCom (com logos, favicons e modificações de UI) para produção.

---

## 📋 Status Atual

### **Modificações Implementadas:**

✅ **Logos e Favicons:**
- Logos SVG customizados (logo.svg, logo_dark.svg, logo_thumbnail.svg)
- Favicons PNG (16x16, 32x32, 96x96, 512x512)
- Ícones Apple, Android e Microsoft
- Configuração `installation_config.yml` atualizada

✅ **Tamanho do Logo:**
- Página de login do usuário: `h-8` → `h-24` (96px)
- Página de login do Super Admin: `h-8` → `h-24` (96px)
- Solução via CSS inline (sem recompilação de assets)

✅ **Git/GitHub:**
- Todas as modificações commitadas em `develop`
- `develop` e `main` estão sincronizados
- Workflows do GitHub Actions corrigidos

### **Estado do Git:**

```bash
# Verificar commits em develop que não estão em main
git log main..develop --oneline
# (Deve estar vazio - develop e main sincronizados)

# Últimos commits em main
git log main --oneline -5
```

---

## 🎯 Objetivo do Deploy

Fazer deploy da versão customizada do CentralCom em produção (`centralcom.hizai.com.br`) **sem afetar**:
- ✅ Configurações existentes
- ✅ Dados do banco de dados
- ✅ Volumes Docker (storage, public, mailers)
- ✅ Funcionamento atual do sistema

---

## 📝 Checklist Pré-Deploy

### **1. Verificações de Segurança**

- [ ] **Backup do banco de dados:**
  ```bash
  # Verificar se script de backup existe
  ls -la /root/scripts/backup_rapido.sh
  
  # Executar backup manual se necessário
  docker exec pgvector pg_dump -U postgres chatwoot > /root/backups/chatwoot_$(date +%Y%m%d_%H%M%S).sql
  ```

- [ ] **Verificar estado atual da produção:**
  ```bash
  # Verificar serviços rodando
  docker service ls | grep chatwoot
  
  # Verificar logs recentes
  docker service logs --tail 50 chatwoot_chatwoot_app
  
  # Verificar saúde do banco
  docker exec pgvector psql -U postgres -d chatwoot -c "SELECT COUNT(*) FROM accounts;"
  ```

- [ ] **Verificar espaço em disco:**
  ```bash
  df -h
  # Garantir pelo menos 2GB livres
  ```

- [ ] **Verificar versão atual em produção:**
  ```bash
  # Verificar imagem atual no YAML
  grep "image:" /root/chatwoot.yaml
  
  # Verificar versão do container rodando
  docker service inspect chatwoot_chatwoot_app --format '{{.Spec.TaskTemplate.ContainerSpec.Image}}'
  ```

### **2. Preparação do Código**

- [ ] **Garantir que develop está atualizado:**
  ```bash
  cd /root/repos/centralcom
  git checkout develop
  git pull origin develop
  git status  # Deve estar limpo
  ```

- [ ] **Merge develop → main (se necessário):**
  ```bash
  # Verificar se há diferenças
  git log main..develop --oneline
  
  # Se houver diferenças, fazer merge
  git checkout main
  git merge develop
  git push origin main
  ```

- [ ] **Verificar Dockerfile:**
  ```bash
  cat /root/repos/centralcom/Dockerfile.centralcom
  # Verificar se todos os arquivos necessários estão sendo copiados
  ```

---

## 🔨 Processo de Deploy

### **Opção 1: Usando Script Automatizado (Recomendado)**

O script `/root/scripts/build_deploy_centralcom.sh` já está configurado para fazer deploy seguro:

```bash
# 1. Build e deploy em produção
cd /root
./scripts/build_deploy_centralcom.sh main both

# O script irá:
# - Fazer backup automático (se configurado)
# - Pedir confirmação antes de deploy em produção
# - Buildar imagem com tag única (v4.1.0-centralcom-YYYYMMDD-HHMMSS)
# - Atualizar chatwoot.yaml automaticamente
# - Fazer deploy do stack
# - Mostrar logs
```

**Vantagens:**
- ✅ Backup automático
- ✅ Confirmação antes de deploy
- ✅ Tag única para cada deploy (facilita rollback)
- ✅ Atualização automática do YAML

### **Opção 2: Deploy Manual (Passo a Passo)**

Se preferir fazer manualmente para ter mais controle:

#### **Passo 1: Build da Imagem**

```bash
cd /root/repos/centralcom

# Garantir que está no branch main
git checkout main
git pull origin main

# Build da imagem com tag única
CHATWOOT_VERSION="v4.1.0"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
IMAGE_TAG="${CHATWOOT_VERSION}-centralcom-${TIMESTAMP}"
FULL_IMAGE_NAME="brunohiz/centralcom:${IMAGE_TAG}"

echo "🔨 Buildando imagem: ${FULL_IMAGE_NAME}"
docker build -f Dockerfile.centralcom -t "${FULL_IMAGE_NAME}" .

# Tag adicional como latest (opcional)
docker tag "${FULL_IMAGE_NAME}" "brunohiz/centralcom:latest"
```

#### **Passo 2: Push para Docker Hub**

```bash
# Login no Docker Hub (se necessário)
docker login

# Push da imagem
echo "📤 Fazendo push para Docker Hub..."
docker push "${FULL_IMAGE_NAME}"
docker push "brunohiz/centralcom:latest"
```

#### **Passo 3: Backup (CRÍTICO)**

```bash
# Backup do banco de dados
echo "💾 Fazendo backup do banco de dados..."
docker exec pgvector pg_dump -U postgres chatwoot > "/root/backups/chatwoot_pre_deploy_$(date +%Y%m%d_%H%M%S).sql"

# Verificar se backup foi criado
ls -lh /root/backups/chatwoot_pre_deploy_*.sql | tail -1
```

#### **Passo 4: Atualizar YAML de Produção**

```bash
# Fazer backup do YAML atual
cp /root/chatwoot.yaml /root/chatwoot.yaml.backup_$(date +%Y%m%d_%H%M%S)

# Atualizar imagem no YAML
sed -i "s|image:.*chatwoot/chatwoot:.*|image: ${FULL_IMAGE_NAME}|g" /root/chatwoot.yaml
sed -i "s|image:.*brunohiz/centralcom:.*|image: ${FULL_IMAGE_NAME}|g" /root/chatwoot.yaml

# Verificar mudanças
echo "📝 Mudanças no YAML:"
diff /root/chatwoot.yaml.backup_* /root/chatwoot.yaml | head -20
```

#### **Passo 5: Deploy do Stack**

```bash
# Deploy
echo "🚀 Fazendo deploy do stack chatwoot..."
docker stack deploy -c /root/chatwoot.yaml chatwoot

# Aguardar alguns segundos
sleep 5

# Verificar status dos serviços
docker service ls | grep chatwoot

# Monitorar logs
docker service logs -f chatwoot_chatwoot_app
# (Pressione Ctrl+C para sair dos logs)
```

#### **Passo 6: Verificação Pós-Deploy**

```bash
# Verificar se serviços estão rodando
docker service ps chatwoot_chatwoot_app
docker service ps chatwoot_chatwoot_sidekiq

# Verificar logs de erro
docker service logs --tail 100 chatwoot_chatwoot_app | grep -i error

# Verificar se aplicação está respondendo
curl -I https://centralcom.hizai.com.br

# Verificar se logo aparece corretamente
# Acessar: https://centralcom.hizai.com.br/login
# Verificar tamanho do logo (deve estar maior - 96px)
```

---

## 🔄 Rollback (Se Necessário)

Se algo der errado, fazer rollback:

### **Rollback Rápido (Usando Imagem Anterior)**

```bash
# 1. Identificar imagem anterior
grep "image:" /root/chatwoot.yaml.backup_* | head -1

# 2. Atualizar YAML com imagem anterior
# (Editar manualmente ou usar sed)

# 3. Deploy novamente
docker stack deploy -c /root/chatwoot.yaml chatwoot
```

### **Rollback Completo (Restaurar YAML)**

```bash
# 1. Restaurar YAML de backup
cp /root/chatwoot.yaml.backup_YYYYMMDD_HHMMSS /root/chatwoot.yaml

# 2. Deploy
docker stack deploy -c /root/chatwoot.yaml chatwoot
```

### **Rollback do Banco de Dados (Se Necessário)**

```bash
# ⚠️ ATENÇÃO: Isso vai restaurar o banco para o estado anterior
# Use apenas se houver problemas críticos

# 1. Parar serviços que usam o banco
docker service scale chatwoot_chatwoot_app=0
docker service scale chatwoot_chatwoot_sidekiq=0

# 2. Restaurar backup
docker exec -i pgvector psql -U postgres chatwoot < /root/backups/chatwoot_pre_deploy_YYYYMMDD_HHMMSS.sql

# 3. Reiniciar serviços
docker service scale chatwoot_chatwoot_app=1
docker service scale chatwoot_chatwoot_sidekiq=1
```

---

## ✅ Verificações Pós-Deploy

Após o deploy, verificar:

### **1. Funcionalidade Básica**

- [ ] Aplicação carrega corretamente: `https://centralcom.hizai.com.br`
- [ ] Login funciona: `https://centralcom.hizai.com.br/login`
- [ ] Logo aparece com tamanho correto (96px)
- [ ] Logo do Super Admin aparece com tamanho correto: `https://centralcom.hizai.com.br/super_admin/sign_in`
- [ ] Favicon aparece corretamente na aba do navegador

### **2. Verificações Técnicas**

```bash
# Verificar se container está rodando
docker service ps chatwoot_chatwoot_app --no-trunc

# Verificar logs de erro
docker service logs --tail 200 chatwoot_chatwoot_app | grep -i error

# Verificar uso de recursos
docker stats $(docker ps -q --filter "name=chatwoot") --no-stream

# Verificar conectividade com banco
docker exec chatwoot_chatwoot_app.1.$(docker service ps chatwoot_chatwoot_app -q --no-trunc | head -1) bundle exec rails runner "puts Account.count"
```

### **3. Verificações de Assets**

- [ ] Logo SVG carrega: `https://centralcom.hizai.com.br/brand-assets/logo.svg`
- [ ] Favicon carrega: `https://centralcom.hizai.com.br/favicon-32x32.png`
- [ ] Ícones Apple carregam: `https://centralcom.hizai.com.br/apple-icon-180x180.png`

---

## 📊 Monitoramento

### **Primeiras 24 Horas:**

Monitorar especialmente:
- Logs de erro
- Uso de memória/CPU
- Tempo de resposta
- Erros de banco de dados

```bash
# Monitorar logs em tempo real
docker service logs -f chatwoot_chatwoot_app

# Monitorar recursos
watch -n 5 'docker stats --no-stream $(docker ps -q --filter "name=chatwoot")'
```

---

## 🚨 Troubleshooting

### **Problema: Container não inicia**

```bash
# Verificar logs detalhados
docker service logs --tail 500 chatwoot_chatwoot_app

# Verificar se imagem existe localmente
docker images | grep centralcom

# Verificar se imagem foi baixada do Docker Hub
docker pull brunohiz/centralcom:TAG
```

### **Problema: Logo não aparece**

```bash
# Verificar se arquivos foram copiados
docker exec chatwoot_chatwoot_app.1.$(docker service ps chatwoot_chatwoot_app -q --no-trunc | head -1) ls -la /app/public/brand-assets/

# Verificar CSS inline
docker exec chatwoot_chatwoot_app.1.$(docker service ps chatwoot_chatwoot_app -q --no-trunc | head -1) cat /app/app/views/layouts/vueapp.html.erb | grep -A 10 "CSS customizado"
```

### **Problema: Erro de banco de dados**

```bash
# Verificar conexão
docker exec chatwoot_chatwoot_app.1.$(docker service ps chatwoot_chatwoot_app -q --no-trunc | head -1) bundle exec rails runner "puts ActiveRecord::Base.connection.execute('SELECT 1').first"

# Verificar migrações pendentes
docker exec chatwoot_chatwoot_app.1.$(docker service ps chatwoot_chatwoot_app -q --no-trunc | head -1) bundle exec rails db:migrate:status
```

---

## ⚠️ PROBLEMA COMUM: Volumes Docker Sobrescrevendo Arquivos

### **Problema:**
O volume Docker `chatwoot_public` montado em `/app/public` **sobrescreve** os arquivos copiados pelo Dockerfile. Isso significa que mesmo após fazer deploy da nova imagem, os arquivos antigos do volume continuam sendo usados.

### **Solução:**
Após fazer deploy, **copiar os arquivos customizados diretamente para o volume Docker**:

```bash
# Copiar logos, favicons e ícones para o volume
docker run --rm \
  -v chatwoot_public:/data \
  -v /root/repos/centralcom/public:/source \
  alpine sh -c "
    cp /source/brand-assets/*.svg /data/brand-assets/ && \
    cp /source/favicon-*.png /data/ && \
    cp /source/apple-icon-*.png /data/ && \
    cp /source/android-icon-*.png /data/ && \
    cp /source/ms-icon-*.png /data/ && \
    echo '✅ Arquivos copiados'
  "

# Reiniciar serviço para garantir que os arquivos sejam recarregados
docker service update --force chatwoot_chatwoot_app
```

### **Por que isso acontece?**
- O Dockerfile copia arquivos para `/app/public` na imagem
- Mas o volume `chatwoot_public` é montado em `/app/public` no container
- Volumes Docker têm prioridade sobre arquivos da imagem
- Portanto, os arquivos do volume sobrescrevem os da imagem

### **Solução Permanente:**
Para evitar ter que copiar manualmente a cada deploy, você pode:
1. **Opção 1:** Criar um script que copia os arquivos após cada deploy
2. **Opção 2:** Modificar o processo de deploy para incluir a cópia automática
3. **Opção 3:** Remover o volume `chatwoot_public` (mas isso pode perder outros arquivos)

---

## 📝 Notas Importantes

1. **Não modificar configurações existentes:** O deploy apenas atualiza a imagem Docker. Todas as configurações (variáveis de ambiente, volumes, rede) permanecem iguais.

2. **Volumes preservados:** Os volumes Docker (`chatwoot_storage`, `chatwoot_public`, etc.) são preservados. **IMPORTANTE:** O volume `chatwoot_public` sobrescreve os arquivos copiados pelo Dockerfile. É necessário copiar os arquivos customizados para o volume após o deploy.

3. **Banco de dados:** Nenhuma migração é executada automaticamente. Se houver migrações pendentes, executar manualmente após o deploy.

4. **Rollback rápido:** Manter sempre a tag da imagem anterior para facilitar rollback.

5. **Backup sempre:** Sempre fazer backup antes de deploy em produção.

---

## 🔗 Referências

- Script de deploy: `/root/scripts/build_deploy_centralcom.sh`
- YAML de produção: `/root/chatwoot.yaml`
- Dockerfile: `/root/repos/centralcom/Dockerfile.centralcom`
- Histórico de modificações: `/root/repos/centralcom/docs/desenvolvimento/HISTORICO_MODIFICACOES.md`
- Guia de estrutura: `/root/repos/centralcom/docs/desenvolvimento/GUIA_ESTRUTURA_CODIGO.md`

---

**Última atualização:** 15/01/2025

