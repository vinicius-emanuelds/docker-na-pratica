# ✅ Correção de Vulnerabilidades em Imagem Docker

## 📌 Objetivo
Corrigir vulnerabilidades de segurança presentes em uma imagem Docker construída com base em um Dockerfile vulnerável. A solução visa aplicar boas práticas de segurança, reduzir a superfície de ataque e manter a compatibilidade com as dependências originais do projeto.

---

## 🔍 Diagnóstico Inicial

### 🔴 Vulnerabilidades detectadas:
Ferramenta utilizada: **Trivy**

- **Sistema base (Debian Slim)**:
  - 105 vulnerabilidades (1 crítica, 2 altas, 102 médias/baixas)
  - Pacotes afetados: `zlib`, `perl-base`, `glibc`, `systemd`, entre outros

- **Dependências Python**:
  - `flask==1.1.1` — vulnerável (CVE-2023-30861)
  - `requests==2.22.0` — vulnerável (CVE-2023-32681)
  - `urllib3`, `setuptools`, `pip`, `idna` — versões antigas com falhas conhecidas

---

## 🔧 Ações Corretivas Aplicadas

### 🧱 Dockerfile – Melhorias estruturais
- Substituição da imagem base `python:3.9` por `python:3.9-slim`
- Criação de usuário e grupo **não-root** (`admin`) para execução segura
- Separação de instruções para aproveitamento de cache:
  - `COPY requirements.txt .` antes de `pip install`
- Instalação das dependências como `root`, antes da troca de usuário
- Atualização dos pacotes do sistema via `apt-get upgrade -y`

```dockerfile
FROM python:3.9-slim

RUN groupadd -r docker_pratica && useradd -r -g docker_pratica admin

WORKDIR /app
RUN chown -R admin:docker_pratica /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

RUN apt-get update && apt-get upgrade -y && apt-get clean

USER admin

COPY . .
