# Listando e Removendo Containers
##### [Voltar para a lista de exercícios](../README.md)

<br>

## Objetivo

Praticar o gerenciamento de containers Docker listando, parando e removendo containers específicos, tanto em execução quanto finalizados.

---

## Passos Realizados

### 1. Listar todos os containers (ativos e inativos)

```bash
docker container ls -a
```

> O parâmetro `-a` lista **todos** os containers, incluindo os que estão **parados**.

![alt text](<../assets/to_README/03 - CONTAINER LS.png>)
---

### 2. Parar um container em execução

```bash
docker stop <ID ou NOME do container>
```


> Exemplo:
```bash
docker stop nginx-tailwind
```

---

### 3. Remover um container específico

```bash
docker rm <ID ou NOME do container>
```
![alt text](<../assets/to_README/03 - DOCKER RM.png>)


> Para remover vários containers:
```bash
docker rm container1 container2 container3
```

![alt text](<../assets/to_README/03 - DOCKER RM (2).png>)

---

## Dica Extra

Para remover todos os containers parados:

```bash
docker container prune
```

⚠️ **Atenção:** Essa ação remove **todos os containers parados**, sem exceção.

---

## Resultado Esperado

- Listagem clara de containers com `docker ls -a`.
- Container parado corretamente com `docker stop`.
- Container removido com sucesso via `docker rm`.
