# Análise de Imagem Docker com Trivy
##### [Voltar para a lista de exercícios](../README.md)

<br>

---

## Objetivo
Utilizar o Trivy para escanear uma imagem Docker pública (`node:16`) e identificar vulnerabilidades de segurança, com foco nas classificadas como `HIGH` ou `CRITICAL`.

<br>

---

## Passo a passo

### 1. Instalar o Trivy

#### Via script (Linux):
```bash
curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin
```

#### Verificar instalação:
```bash
trivy --version
```

<br>

---


### 2. Rodar análise de imagem

```bash
trivy image --severity HIGH,CRITICAL node:16
```
> O uso de `--severity` limita a análise às vulnerabilidades de alta e crítica.

![alt text](<../assets/to_README/11 - TRIVY.png>)

Como alternativa, você pode redirecionar a saída para um arquivo de texto:

```bash
trivy image --severity HIGH,CRITICAL node:16 > relatorio-trivy.txt
```
![alt text](<../assets/to_README/11 - CAT.png>)

<br>

---

## Análise Final

Com base no relatório gerado pelo Trivy e armazenado em `relatorio-trivy.txt`, os pontos principais são:

### 🔍 Resumo da Análise

- **Imagem escaneada**: `node:16` (baseada em Debian 10.13)
- **Total de vulnerabilidades**: **1.141**
  - **HIGH**: 1.110
  - **CRITICAL**: 31

![alt text](<../assets/to_README/11 - DEBIAN.png>)

A grande maioria das vulnerabilidades provém de **bibliotecas do sistema operacional** como:
- `glibc`, `gcc`, `openssl`, `curl`, `imagemagick`, entre outras.

---

### 📦 Pacotes Node.js

Apenas **2 pacotes** do Node.js apresentaram vulnerabilidades:

| Pacote  | CVE             | Severidade | Status    | Ação recomendada                      |
|---------|------------------|------------|-----------|---------------------------------------|
| `ip`    | CVE-2024-29415   | HIGH       | Affected  | Aguardar correção ou reavaliar uso    |
| `semver`| CVE-2022-25883   | HIGH       | Fixed     | Atualizar para versão `^7.5.2`        |

![alt text](<../assets/to_README/11 - NODE.png>)

**Observação**: Nenhuma dependência crítica da aplicação foi afetada diretamente de forma ativa ou irreversível.

<br>

---

### ⚠️ Conclusão

> As recomendações de segurança não devem se restringir à atualização das dependências Node.js, pois o maior risco está relacionado à base Debian.



1. **Atualizar a imagem base**
   - Troque `node:16` por `node:20-alpine` ou `node:18-alpine`:
     ```dockerfile
     FROM node:20-alpine
     ```
   - O Alpine Linux é **muito mais enxuto**, com menos pacotes e menor superfície de ataque.

2. **Atualizar dependências**
   - Ajustar no `package.json`:
     ```json
     "semver": "^7.5.2"
     ```

3. **Evitar bibliotecas desnecessárias**
   - Avaliar se o pacote `ip` é realmente necessário no seu projeto.
   - Substituir ou isolar seu uso enquanto não há versão corrigida.