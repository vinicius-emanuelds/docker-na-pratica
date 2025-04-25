# Correção de Vulnerabilidades em Imagem Docker

##### [Voltar para a lista de exercícios](../README.md)

<br>

---

## Objetivo

Corrigir vulnerabilidades de segurança presentes em uma imagem Docker construída com base em um `Dockerfile` vulnerável.  
A solução visa:

- Aplicar boas práticas de segurança.
- Reduzir a superfície de ataque.
- Manter a compatibilidade com as dependências originais do projeto.

![alt text](<../assets/to_README/12 - DOCKERFILE ANTIGO.PNG>)

<br>

---

## Diagnóstico Inicial

 **Ferramenta utilizada**: `Trivy`
 ```bash
 trivy image dockerfile-vulneravel:latest
 ```
  **Resultado**: 
  [Relatório completo](relatorio-trivy.txt)
  
 ![alt text](<../assets/to_README/12 - SUMARIO ANTES.png>)

### Sistema base (`python:3.9`)
- **Base Debian Slim**:
  - 105 vulnerabilidades:
    - 🔴 Críticas: 1
    - 🟠 Altas: 2
    - 🔵 Médias/Baixas: 102
  - Pacotes afetados: `zlib`, `perl-base`, `glibc`, `systemd`, entre outros

### Dependências Python
| Pacote     | Versão  | Vulnerabilidade | CVE                  |
|------------|---------|-----------------|-----------------------|
| flask      | 1.1.1   | Sim             | CVE-2023-30861        |
| requests   | 2.22.0  | Sim             | CVE-2023-32681        |
| urllib3, setuptools, pip, idna | Versões desatualizadas com falhas conhecidas |

<br>

---

## Ações Corretivas

### Dockerfile – Melhorias estruturais

- **Imagem base**: `python:3.9-slim`  
  Mais leve e com menor superfície de ataque comparada à `python:3.9`.
  
- **Usuário não-root**:
  Criação de grupo e usuário (`admin`) para evitar execução como root.

- **Otimização de cache Docker**:
  - `COPY requirements.txt` antes do `COPY .`
  - Instalação de dependências antes da troca de usuário

-  **Correções de segurança no SO**:
  Atualização de pacotes via `apt-get upgrade -y` e limpeza de cache

- **Remoção de arquivos desnecessários**:
  - `.git`, `__pycache__`, `venv`, arquivos de log, testes e documentação

<br>

## Novo `Dockerfile`

```Dockerfile
FROM python:3.9-slim

RUN groupadd -r docker_pratica && useradd -r -g docker_pratica admin

WORKDIR /app

RUN chown -R admin:docker_pratica /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN apt-get update && apt-get upgrade -y && apt-get clean

USER admin
```

<br>

## Novo `requirements.txt`

```txt
flask==2.2.5
requests==2.32.0
urllib3==1.26.19
setuptools==70.0.0
idna==3.7
pip==23.3
```

## Novo `.dockerignore`

```dockerignore
# Ignora diretórios de cache e build do Python
__pycache__/
*.pyc

# Ignora diretórios do Git
.git/
.gitignore

# Ignora ambientes virtuais
venv/

# Ignora arquivos de log
*.log

# Ignora arquivos de testes e outros arquivos desnecessários
tests/
*.md
```

> **Importância**: reduz o tamanho da imagem, evita exposição de dados sensíveis e melhora performance no build.

<br>

---

## Resultados Esperados

![alt text](<../assets/to_README/12 - SUMARIO DEPOIS.png>)

- Imagem mais leve, segura e limpa
- Processo rodando com usuário não-root
- Nenhuma vulnerabilidade crítica ativa detectada no Trivy
- Melhor aproveitamento do cache do Docker
- As vulnerabilidades relacionadas ao *Debian* são comuns e não afetam o funcionamento do projeto
