# 📋 Especificações Técnicas - Logo e Favicon CentralCom

## 📍 ONDE O LOGO/FAVICON APARECE

### **1. LOGOS PRINCIPAIS (SVG)**

#### **1.1. `logo.svg`** - Logo Principal (Modo Claro)
- **Localização:** `/public/brand-assets/logo.svg`
- **Uso:**
  - Dashboard principal (sidebar, header)
  - Página de login (modo claro)
  - Página de onboarding
  - Super Admin Dashboard (navegação)
  - Help Center (footer)
  - Emails (quando aplicável)
- **Dimensões atuais:** 2458px × 512px (proporção ~4.8:1)
- **Formato:** SVG
- **ViewBox:** `0 0 2458 512`
- **Cores:** Texto escuro (#273444) sobre fundo claro

#### **1.2. `logo_dark.svg`** - Logo Modo Escuro
- **Localização:** `/public/brand-assets/logo_dark.svg`
- **Uso:**
  - Dashboard (quando dark mode ativo)
  - Página de login (modo escuro)
  - Página de onboarding (modo escuro)
- **Dimensões atuais:** 2458px × 512px (proporção ~4.8:1)
- **Formato:** SVG
- **ViewBox:** `0 0 2458 512`
- **Cores:** Texto claro (#EDEDED) sobre fundo escuro

#### **1.3. `logo_thumbnail.svg`** - Logo Thumbnail (Favicon)
- **Localização:** `/public/brand-assets/logo_thumbnail.svg`
- **Uso:**
  - Favicon principal (512×512)
  - Widget de chat (branding "Powered by")
  - Preview do widget
  - Componente Logo pequeno (16×16)
  - Survey/Formulários
- **Dimensões atuais:** 16px × 16px
- **Formato:** SVG
- **ViewBox:** `0 0 16 16`
- **Importante:** Deve ser quadrado (1:1) e legível em tamanhos muito pequenos

---

### **2. FAVICONS (PNG)**

#### **2.1. Favicons Padrão**
Todos os favicons são gerados a partir do `logo_thumbnail.svg`:

| Arquivo | Tamanho | Uso |
|---------|---------|-----|
| `favicon-16x16.png` | 16×16px | Favicon padrão (navegadores) |
| `favicon-32x32.png` | 32×32px | Favicon HD (navegadores modernos) |
| `favicon-96x96.png` | 96×96px | Favicon grande (alguns navegadores) |
| `favicon-512x512.png` | 512×512px | Favicon principal (HTML5) |

#### **2.2. Favicons com Badge (Notificações)**
Quando há mensagens não lidas, o sistema troca para versões com badge:

| Arquivo | Tamanho | Uso |
|---------|---------|-----|
| `favicon-badge-16x16.png` | 16×16px | Favicon com badge de notificação |
| `favicon-badge-32x32.png` | 32×32px | Favicon HD com badge |
| `favicon-badge-96x96.png` | 96×96px | Favicon grande com badge |

---

### **3. ÍCONES APPLE (iOS/macOS)**

| Arquivo | Tamanho | Uso |
|---------|---------|-----|
| `apple-icon-57x57.png` | 57×57px | iOS antigo |
| `apple-icon-60x60.png` | 60×60px | iOS 7+ |
| `apple-icon-72x72.png` | 72×72px | iPad antigo |
| `apple-icon-76x76.png` | 76×76px | iPad |
| `apple-icon-114x114.png` | 114×114px | iPhone Retina |
| `apple-icon-120x120.png` | 120×120px | iPhone Retina HD |
| `apple-icon-144x144.png` | 144×144px | iPad Retina |
| `apple-icon-152x152.png` | 152×152px | iPad Retina |
| `apple-icon-180x180.png` | 180×180px | iPhone 6+ (atual) |
| `apple-touch-icon.png` | 192×192px | Fallback genérico |
| `apple-icon-precomposed.png` | 192×192px | Fallback alternativo |

---

### **4. ÍCONES ANDROID (PWA)**

| Arquivo | Tamanho | Densidade | Uso |
|---------|---------|-----------|-----|
| `android-icon-36x36.png` | 36×36px | 0.75x | Android baixa resolução |
| `android-icon-48x48.png` | 48×48px | 1.0x | Android padrão |
| `android-icon-72x72.png` | 72×72px | 1.5x | Android média resolução |
| `android-icon-96x96.png` | 96×96px | 2.0x | Android alta resolução |
| `android-icon-144x144.png` | 144×144px | 3.0x | Android muito alta resolução |
| `android-icon-192x192.png` | 192×192px | 4.0x | Android máxima resolução (PWA) |

---

### **5. ÍCONES MICROSOFT (Windows)**

| Arquivo | Tamanho | Uso |
|---------|---------|-----|
| `ms-icon-70x70.png` | 70×70px | Windows tile pequeno |
| `ms-icon-150x150.png` | 150×150px | Windows tile médio |
| `ms-icon-310x310.png` | 310×310px | Windows tile grande |
| `ms-icon-144x144.png` | 144×144px | Windows tile padrão |

---

## 🎨 ESPECIFICAÇÕES TÉCNICAS DETALHADAS

### **LOGO PRINCIPAL (`logo.svg` e `logo_dark.svg`)**

#### **Formato:**
- **Tipo:** SVG (Scalable Vector Graphics)
- **Versão:** SVG 1.1
- **Encoding:** UTF-8
- **Namespace:** `http://www.w3.org/2000/svg`

#### **Dimensões:**
- **Largura recomendada:** 2000-3000px (ideal: 2458px)
- **Altura recomendada:** 400-600px (ideal: 512px)
- **Proporção:** ~4.8:1 (horizontal, retangular)
- **ViewBox:** Deve ser definido para permitir escalonamento perfeito
- **Exemplo:** `viewBox="0 0 2458 512"`

#### **Qualidade:**
- **Vetor:** Deve ser 100% vetorial (sem imagens rasterizadas)
- **Paths:** Usar paths SVG otimizados
- **Cores:** Usar cores sólidas ou gradientes simples
- **Transparência:** Suportada (mas não necessária para logo principal)

#### **Design:**
- **Estilo:** Horizontal (landscape)
- **Legibilidade:** Deve ser legível em tamanhos de 100px até 2000px+
- **Espaçamento:** Manter margem de segurança de ~10% nas bordas
- **Cores modo claro:** Texto/preenchimento escuro (#273444 ou similar)
- **Cores modo escuro:** Texto/preenchimento claro (#EDEDED ou similar)

#### **Estrutura SVG recomendada:**
```xml
<?xml version="1.0" encoding="UTF-8"?>
<svg width="2458px" height="512px" viewBox="0 0 2458 512" version="1.1" 
     xmlns="http://www.w3.org/2000/svg">
    <g id="Logo" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
        <!-- Seu conteúdo aqui -->
    </g>
</svg>
```

---

### **LOGO THUMBNAIL (`logo_thumbnail.svg`)**

#### **Formato:**
- **Tipo:** SVG
- **Versão:** SVG 1.1
- **Encoding:** UTF-8

#### **Dimensões:**
- **Tamanho:** 16px × 16px (QUADRADO - 1:1)
- **ViewBox:** `0 0 16 16`
- **Proporção:** 1:1 (OBRIGATÓRIO - quadrado perfeito)

#### **Qualidade:**
- **Vetor:** 100% vetorial
- **Simplicidade:** Deve ser MUITO simples (ícone/símbolo)
- **Legibilidade:** Deve ser reconhecível em 16×16px
- **Detalhes:** Evitar detalhes finos que desaparecem em tamanho pequeno

#### **Design:**
- **Estilo:** Quadrado, compacto
- **Cores:** Pode ter fundo colorido (como o Chatwoot tem círculo azul)
- **Contraste:** Alto contraste para visibilidade
- **Margem:** Deixar ~1-2px de margem interna para não cortar

#### **Estrutura SVG recomendada:**
```xml
<svg width="16" height="16" viewBox="0 0 16 16" fill="none" 
     xmlns="http://www.w3.org/2000/svg">
    <!-- Conteúdo simples e quadrado -->
</svg>
```

---

### **FAVICONS PNG**

#### **Formato:**
- **Tipo:** PNG
- **Profundidade de cor:** 32-bit RGBA (com transparência)
- **Compressão:** Otimizada (sem perda de qualidade visível)

#### **Dimensões e Qualidade:**

| Tamanho | Resolução | Qualidade | Uso |
|---------|-----------|-----------|-----|
| 16×16 | 72 DPI | Alta | Favicon padrão |
| 32×32 | 72 DPI | Alta | Favicon HD |
| 96×96 | 72 DPI | Alta | Favicon grande |
| 512×512 | 72 DPI | Muito Alta | Favicon principal |

#### **Especificações:**
- **Fundo:** Transparente (RGBA com alpha channel)
- **Bordas:** Sem bordas brancas/pretas
- **Anti-aliasing:** Ativado (bordas suaves)
- **Interpolação:** Bicúbica (melhor qualidade ao redimensionar)

#### **Geração:**
- **Fonte:** Gerar a partir do `logo_thumbnail.svg` em alta resolução
- **Processo:** 
  1. Renderizar SVG em 512×512px (ou maior)
  2. Redimensionar para cada tamanho necessário
  3. Otimizar PNG (usar pngquant ou similar)

---

### **ÍCONES APPLE (PNG)**

#### **Formato:**
- **Tipo:** PNG
- **Profundidade:** 32-bit RGBA
- **Fundo:** Pode ter fundo (iOS adiciona cantos arredondados automaticamente)

#### **Dimensões:**
- **Todos quadrados:** 1:1 (obrigatório)
- **Tamanhos:** Ver tabela acima
- **Resolução:** 72 DPI (padrão web)

#### **Design:**
- **Cantos:** iOS arredonda automaticamente, não precisa fazer
- **Margem:** Deixar ~10% de margem interna (iOS pode cortar bordas)
- **Cores:** Cores vibrantes funcionam bem
- **Detalhes:** Evitar texto muito pequeno

---

### **ÍCONES ANDROID (PNG)**

#### **Formato:**
- **Tipo:** PNG
- **Profundidade:** 32-bit RGBA
- **Fundo:** Transparente ou sólido (depende do design)

#### **Dimensões:**
- **Todos quadrados:** 1:1
- **Tamanhos:** Ver tabela acima
- **Resolução:** 72 DPI

#### **Design:**
- **Adaptativo:** Android pode aplicar máscaras
- **Cores:** Material Design recomenda cores vibrantes
- **Margem:** ~10% de margem interna

---

### **ÍCONES MICROSOFT (PNG)**

#### **Formato:**
- **Tipo:** PNG
- **Profundidade:** 32-bit RGBA
- **Fundo:** Geralmente transparente

#### **Dimensões:**
- **Todos quadrados:** 1:1
- **Tamanhos:** Ver tabela acima
- **Resolução:** 72 DPI

---

## 📝 CHECKLIST PARA GERAÇÃO

### **Para a IA Gerar Corretamente:**

#### **1. Logo Principal (`logo.svg`):**
```
✅ Formato: SVG
✅ Dimensões: 2458px × 512px (ou proporção similar ~4.8:1)
✅ Proporção: Horizontal (landscape)
✅ ViewBox: Definido corretamente
✅ 100% vetorial (sem imagens rasterizadas)
✅ Cores modo claro: Escuro sobre claro
✅ Cores modo escuro: Claro sobre escuro
✅ Legível de 100px a 2000px+
✅ Margem de segurança ~10%
```

#### **2. Logo Thumbnail (`logo_thumbnail.svg`):**
```
✅ Formato: SVG
✅ Dimensões: 16px × 16px (QUADRADO - 1:1)
✅ ViewBox: 0 0 16 16
✅ Proporção: 1:1 (quadrado perfeito)
✅ 100% vetorial
✅ Design MUITO simples (ícone/símbolo)
✅ Legível em 16×16px
✅ Alto contraste
✅ Margem interna ~1-2px
```

#### **3. Favicons PNG:**
```
✅ Formato: PNG 32-bit RGBA
✅ Tamanhos: 16×16, 32×32, 96×96, 512×512
✅ Fundo: Transparente
✅ Anti-aliasing: Ativado
✅ Gerado a partir do logo_thumbnail.svg
✅ Qualidade alta (sem compressão excessiva)
```

#### **4. Ícones Apple:**
```
✅ Formato: PNG 32-bit RGBA
✅ Tamanhos: 57, 60, 72, 76, 114, 120, 144, 152, 180, 192×192
✅ Todos quadrados (1:1)
✅ Margem interna ~10%
✅ Cores vibrantes
```

#### **5. Ícones Android:**
```
✅ Formato: PNG 32-bit RGBA
✅ Tamanhos: 36, 48, 72, 96, 144, 192×192
✅ Todos quadrados (1:1)
✅ Margem interna ~10%
```

#### **6. Ícones Microsoft:**
```
✅ Formato: PNG 32-bit RGBA
✅ Tamanhos: 70, 144, 150, 310×310
✅ Todos quadrados (1:1)
```

---

## 🎯 PROMPT SUGERIDO PARA IA GERAR

### **Para Logo Principal:**
```
Crie um logo SVG horizontal para "CentralCom" com as seguintes especificações:

- Formato: SVG 1.1, UTF-8
- Dimensões: 2458px de largura × 512px de altura (proporção ~4.8:1)
- ViewBox: "0 0 2458 512"
- Estilo: Horizontal (landscape), moderno, profissional
- Cores modo claro: Texto/preenchimento escuro (#273444) sobre fundo claro
- Cores modo escuro: Texto/preenchimento claro (#EDEDED) sobre fundo escuro
- 100% vetorial (sem imagens rasterizadas)
- Legível de 100px a 2000px+
- Margem de segurança de ~10% nas bordas
- Design limpo e profissional para plataforma de atendimento
```

### **Para Logo Thumbnail (Favicon):**
```
Crie um ícone SVG quadrado para "CentralCom" com as seguintes especificações:

- Formato: SVG 1.1, UTF-8
- Dimensões: 16px × 16px (QUADRADO PERFEITO - proporção 1:1)
- ViewBox: "0 0 16 16"
- Estilo: Ícone/símbolo simples, compacto, quadrado
- Design: MUITO simples (deve ser reconhecível em 16×16px)
- Cores: Pode ter fundo colorido (círculo/quadrado com cor de marca)
- Alto contraste para visibilidade
- Margem interna de ~1-2px
- 100% vetorial
- Evitar detalhes finos que desaparecem em tamanho pequeno
- Deve funcionar como favicon (ser legível em tamanho muito pequeno)
```

### **Para Favicons PNG:**
```
Gere favicons PNG a partir do logo_thumbnail.svg nas seguintes especificações:

- Formato: PNG 32-bit RGBA (com transparência)
- Tamanhos: 16×16, 32×32, 96×96, 512×512 pixels
- Fundo: Transparente
- Anti-aliasing: Ativado (bordas suaves)
- Qualidade: Alta (sem compressão excessiva)
- Todos quadrados (1:1)
- Renderizar do SVG em alta resolução primeiro, depois redimensionar
```

---

## 📂 ESTRUTURA DE ARQUIVOS FINAL

```
/public/
├── brand-assets/
│   ├── logo.svg              (2458×512px, horizontal)
│   ├── logo_dark.svg          (2458×512px, horizontal)
│   └── logo_thumbnail.svg    (16×16px, quadrado)
│
├── favicon-16x16.png          (16×16px, quadrado, transparente)
├── favicon-32x32.png          (32×32px, quadrado, transparente)
├── favicon-96x96.png          (96×96px, quadrado, transparente)
├── favicon-512x512.png        (512×512px, quadrado, transparente)
│
├── favicon-badge-16x16.png    (16×16px, com badge de notificação)
├── favicon-badge-32x32.png    (32×32px, com badge de notificação)
├── favicon-badge-96x96.png    (96×96px, com badge de notificação)
│
├── apple-icon-57x57.png       (57×57px, quadrado)
├── apple-icon-60x60.png       (60×60px, quadrado)
├── apple-icon-72x72.png       (72×72px, quadrado)
├── apple-icon-76x76.png       (76×76px, quadrado)
├── apple-icon-114x114.png     (114×114px, quadrado)
├── apple-icon-120x120.png     (120×120px, quadrado)
├── apple-icon-144x144.png     (144×144px, quadrado)
├── apple-icon-152x152.png     (152×152px, quadrado)
├── apple-icon-180x180.png     (180×180px, quadrado)
├── apple-touch-icon.png       (192×192px, quadrado)
└── apple-icon-precomposed.png (192×192px, quadrado)
│
├── android-icon-36x36.png    (36×36px, quadrado)
├── android-icon-48x48.png     (48×48px, quadrado)
├── android-icon-72x72.png     (72×72px, quadrado)
├── android-icon-96x96.png     (96×96px, quadrado)
├── android-icon-144x144.png   (144×144px, quadrado)
└── android-icon-192x192.png   (192×192px, quadrado)
│
├── ms-icon-70x70.png          (70×70px, quadrado)
├── ms-icon-144x144.png        (144×144px, quadrado)
├── ms-icon-150x150.png        (150×150px, quadrado)
└── ms-icon-310x310.png        (310×310px, quadrado)
```

---

## ⚠️ OBSERVAÇÕES IMPORTANTES

1. **Logo Thumbnail é CRÍTICO:** É usado em muitos lugares pequenos, então deve ser MUITO simples e legível
2. **Proporção 1:1 obrigatória:** Todos os favicons e ícones devem ser quadrados perfeitos
3. **SVG é preferível:** Para logos, sempre use SVG (escalável sem perda)
4. **PNG para ícones:** Favicons e ícones de app devem ser PNG (melhor compatibilidade)
5. **Transparência:** Favicons devem ter fundo transparente
6. **Badge de notificação:** Os favicons com badge serão gerados depois (não precisa criar agora)
7. **Margem de segurança:** Sempre deixe margem interna para evitar cortes em diferentes dispositivos

---

## 🔧 FERRAMENTAS ÚTEIS

- **SVG Optimizer:** SVGO, SVGOMG
- **PNG Optimizer:** pngquant, TinyPNG, ImageOptim
- **Gerador de Favicons:** RealFaviconGenerator, Favicon.io
- **Conversor SVG→PNG:** Inkscape, ImageMagick, librsvg

---

**Última atualização:** 2024-12-19

