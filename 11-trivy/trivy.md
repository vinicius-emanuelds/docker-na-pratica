Claro! Aqui está a documentação em **Markdown** para o exercício 11, incluindo instalação do Trivy, execução da análise e recomendações com base nos resultados:

---

```markdown
# Exercício 11 – Análise de Imagem Docker com Trivy

## 🎯 Objetivo
Utilizar o Trivy para escanear uma imagem Docker pública (`node:16`) e identificar vulnerabilidades de segurança, com foco nas classificadas como `HIGH` ou `CRITICAL`.

---

## 📥 Passo a passo

### 1. Instalar o Trivy

#### Via script (Linux):
```bash
curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin
```

#### Verificar instalação:
```bash
trivy --version
```

---

### 2. Rodar análise de imagem
```bash
trivy image node:16
```

---

## 📊 Resultado da Análise

### 🔧 Sistema Operacional: Debian 10.13 (imagem base `node:16`)
- **Total de vulnerabilidades:** 1.141
  - **HIGH:** 1.110
  - **CRITICAL:** 31

🔴 Muitas dessas vulnerabilidades vêm de bibliotecas fundamentais (`glibc`, `openssl`, `libssl`, `zlib`), que impactam diretamente a segurança do container.

---

### 📦 Pacotes Node.js

| Pacote | Vulnerabilidade | Severidade | Status | Versão Afetada | Versão Corrigida |
|--------|------------------|------------|--------|----------------|------------------|
| `ip`   | CVE-2024-29415   | HIGH       | Affected | 2.0.0        | - (ainda não corrigida) |
| `semver` | CVE-2022-25883 | HIGH       | Fixed   | 7.3.7         | 7.5.2, 6.3.1, 5.7.2 |

---

## ✅ Recomendações

### 1. **Atualizar imagem base**
Substituir `node:16` por uma versão mais segura e recente:

```dockerfile
FROM node:20-alpine
```

- Reduz drasticamente as vulnerabilidades do SO.
- Imagem mais enxuta e segura.

---

### 2. **Atualizar dependências**
No `package.json`, atualizar o pacote `semver` para a versão corrigida:

```json
"semver": "^7.5.2"
```

### 3. **Revisar uso do pacote `ip`**
- Confirmar necessidade real.
- Se possível, remover ou substituir.
- Aguardar correção se o uso for indispensável.

---

## 🧪 Validação pós-ajustes

Rebuild da imagem:
```bash
docker build -t app-seguro .
```

Nova análise:
```bash
trivy image app-seguro
```

---

## 🔚 Conclusão

Este exercício reforça a importância da segurança na escolha de imagens base e na manutenção das dependências. O uso do Trivy permite decisões proativas para mitigar riscos antes mesmo da implantação.

---
```

Se desejar, posso transformar este conteúdo em PDF ou adicionar ao seu repositório como `README.md`. Deseja isso?