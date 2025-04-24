# Exercício 03 – Listando e Removendo Containers

## 🎯 Objetivo

Praticar o gerenciamento de containers Docker listando, parando e removendo containers específicos, tanto em execução quanto finalizados.

---

## 🧪 Passos Realizados

### 🔍 1. Listar todos os containers (ativos e inativos)

```bash
docker ps -a
```

> O parâmetro `-a` lista **todos** os containers, incluindo os que estão **parados**.

---

### ⛔ 2. Parar um container em execução

```bash
docker stop <ID ou NOME do container>
```

> Exemplo:
```bash
docker stop amazing_einstein
```

---

### 🗑️ 3. Remover um container específico

```bash
docker rm <ID ou NOME do container>
```

> Exemplo:
```bash
docker rm amazing_einstein
```

> Para remover vários containers:
```bash
docker rm container1 container2 container3
```

---

## 💡 Dica Extra

Para remover todos os containers parados:

```bash
docker container prune
```

⚠️ **Atenção:** Essa ação remove **todos os containers parados**, sem exceção.

---

## ✅ Resultado Esperado

- Listagem clara de containers com `docker ps -a`.
- Container parado corretamente com `docker stop`.
- Container removido com sucesso via `docker rm`.

---
