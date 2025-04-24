#! /usr/bin/env bash

apt-get update -y && apt-get upgrade -y

apt-get install nginx -y

service nginx start

cat << 'EOF' > /var/www/html/index.html
<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Práticas com Docker e Segurança</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        :root {
            --bg-color: #f8f9fa;
            --text-color: #212529;
            --card-bg: #ffffff;
            --code-bg: #e9ecef;
            --nav-bg: #212529;
        }

        body.dark-mode {
            --bg-color: #212529;
            --text-color: #f8f9fa;
            --card-bg: #2d3339;
            --code-bg: #1e1e1e;
            --nav-bg: #141619;
        }

        body {
            background-color: var(--bg-color);
            color: var(--text-color);
            transition: background-color 0.3s, color 0.3s;
        }

        .navbar {
            background-color: var(--nav-bg) !important;
        }

        .card {
            margin-bottom: 20px;
            background-color: var(--card-bg);
            border: 1px solid rgba(0,0,0,0.125);
        }

        .section-title {
            margin-top: 60px;
            border-bottom: 2px solid #0d6efd;
            padding-bottom: 0.5rem;
        }

        .btn-group-fab {
            position: fixed;
            bottom: 30px;
            right: 30px;
            z-index: 1000;
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .btn-fab {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            transition: transform 0.2s;
        }

        .btn-fab:hover {
            transform: scale(1.1);
        }

        .code-snippet {
            background-color: var(--code-bg);
            padding: 1rem;
            border-radius: 0.5rem;
            font-family: 'Courier New', Courier, monospace;
            overflow-x: auto;
            color: inherit;
            margin: 1rem 0;
        }

        .dark-mode .modal-content {
            background-color: var(--card-bg);
            color: var(--text-color);
            border: 1px solid #495057;
        }

        .dark-mode .modal-header {
            border-bottom: 1px solid #495057;
        }

        .dark-mode .modal-footer {
            border-top: 1px solid #495057;
        }

        .dark-mode .btn-close {
            filter: invert(1);
        }

        a {
            color: #0d6efd;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }

        ul {
            padding-left: 1.5rem;
        }

        li {
            margin-bottom: 0.5rem;
        }
    </style>
</head>

<body>
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">
                <i class="bi bi-docker me-2 "></i><strong>DOCKER NA PRÁTICA</strong>
            </a>
        </div>
    </nav>

    <div class="container py-5">
        <section id="modais">
            <h2 class="section-title"><i class="bi bi-list-task me-2"></i>Níveis de Dificuldade</h2>

            <div class="d-flex flex-column gap-3">
                <button class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#modalFacil">
                    <i class="bi bi-flag-fill me-2"></i>Fácil
                </button>
                <button class="btn btn-outline-warning" data-bs-toggle="modal" data-bs-target="#modalMedio">
                    <i class="bi bi-flag-fill me-2"></i>Médio
                </button>
                <button class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#modalDificil">
                    <i class="bi bi-flag-fill me-2"></i>Difícil
                </button>
            </div>
        </section>

        <section id="sobre" class="mt-5">
            <h1 class="section-title"><i class="bi bi-person-circle me-2"></i>Sobre mim</h1>
            <h3><strong><i class="bi bi-hand-thumbs-up me-2"></i>Olá! Eu sou o Vinicius Emanuel!</strong></h3>
            <blockquote><strong>Do jaleco branco à Tech Lover!</strong></blockquote>
            <p>Graduando em Análise e Desenvolvimento de Sistemas pela <a href="https://fatecmm.cps.sp.gov.br/"
                    target="_blank">FATEC Arthur de Azevedo</a> e atualmente estagiando em Cloud & DevSecOps na Compass
                UOL, estou em plena transição de carreira. Saí da área da saúde não por insatisfação, mas por vocação:
                descobri na tecnologia uma forma mais escalável de continuar resolvendo problemas reais, com empatia,
                lógica e impacto.</p>
            <p>Com 32 anos, estou mergulhado no universo do desenvolvimento Full Stack e da computação em nuvem —
                aprendendo, construindo e conectando os pontos entre pessoas, sistemas e propósito.</p>

            <h5><i class="bi bi-stack me-2"></i>Áreas de atuação e interesses:</h5>
            <ul>
                <li><i class="bi bi-cloud me-2"></i>Cloud & DevSecOps</li>
                <li><i class="bi bi-code-square me-2"></i>Infraestrutura como Código (IaC)</li>
                <li><i class="bi bi-layers me-2"></i>Desenvolvimento Full Stack</li>
                <li><i class="bi bi-shield-lock me-2"></i>Segurança em ambientes em nuvem</li>
                <li><i class="bi bi-heart-pulse me-2"></i>Projetos com impacto social ou organizacional</li>
            </ul>

            <h5><i class="bi bi-clock-history me-2"></i>Atualmente:</h5>
            <ul>
                <li><i class="bi bi-building me-2"></i>Estagiário em Cloud & DevSecOps na Compass UOL</li>
                <li><i class="bi bi-book me-2"></i>Estudante de ADS na FATEC Arthur de Azevedo</li>
                <li><i class="bi bi-heart-pulse me-2"></i>Ainda atuando na área da saúde (transição com os dois pés no chão)</li>
                <li><i class="bi bi-code-slash me-2"></i>Estudando AWS, C, Linux, Shell Script, Git, JavaScript, HTML e CSS</li>
            </ul>

            <p class="mt-4">
                <i class="bi bi-link-45deg me-2"></i>Conecte-se comigo:
                <a class="me-3" href="https://github.com/vinicius-emanuelds" target="_blank">
                    <i class="bi bi-github me-1"></i>GitHub
                </a>
                <a href="https://www.linkedin.com/in/viniciusesilva/" target="_blank">
                    <i class="bi bi-linkedin me-1"></i>LinkedIn
                </a>
            </p>
        </section>
    </div>

    <div class="btn-group-fab">
        <button class="btn btn-primary btn-fab" onclick="window.scrollTo({top: 0, behavior: 'smooth'});">
            <i class="bi bi-arrow-up"></i>
        </button>
        <button class="btn btn-secondary btn-fab" onclick="toggleMode()">
            <i class="bi bi-sun" id="modeIcon"></i>
        </button>
    </div>

    <!-- Modais -->
    <div class="modal fade" id="modalFacil" tabindex="-1" aria-labelledby="modalFacilLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="bi bi-flag me-2"></i>Nível Fácil</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Fechar"></button>
                </div>
                <div class="modal-body">
                    <ul class="mb-4">
                        <li><i class="bi bi-check-circle me-2"></i>Rodando um container básico com Nginx</li>
                        <li><i class="bi bi-check-circle me-2"></i>Container interativo com Ubuntu</li>
                        <li><i class="bi bi-check-circle me-2"></i>Listagem e remoção de containers</li>
                        <li><i class="bi bi-check-circle me-2"></i>Dockerfile para app Flask</li>
                    </ul>
                    <div class="code-snippet">
                        <span class="text-success">$</span> docker run -d -p 8080:80 nginx
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="modalMedio" tabindex="-1" aria-labelledby="modalMedioLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="bi bi-flag-fill me-2"></i>Nível Médio</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Fechar"></button>
                </div>
                <div class="modal-body">
                    <ul class="mb-4">
                        <li><i class="bi bi-check-circle me-2"></i>Volumes com MySQL</li>
                        <li><i class="bi bi-check-circle me-2"></i>Multi-stage com app Go</li>
                        <li><i class="bi bi-check-circle me-2"></i>Rede personalizada com Node e MongoDB</li>
                        <li><i class="bi bi-check-circle me-2"></i>Compose com PostgreSQL</li>
                    </ul>
                    <div class="code-snippet">
                        <span class="text-success">$</span> docker volume create mysql_data
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="modalDificil" tabindex="-1" aria-labelledby="modalDificilLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="bi bi-flag-fill me-2"></i>Nível Difícil</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Fechar"></button>
                </div>
                <div class="modal-body">
                    <ul class="mb-4">
                        <li><i class="bi bi-check-circle me-2"></i>Imagem personalizada com arquivos estáticos</li>
                        <li><i class="bi bi-check-circle me-2"></i>Execução com usuário não-root</li>
                        <li><i class="bi bi-check-circle me-2"></i>Análise com Trivy</li>
                        <li><i class="bi bi-check-circle me-2"></i>Correção de vulnerabilidades</li>
                    </ul>
                    <div class="code-snippet">
                        <span class="text-success">$</span> trivy image nome-da-imagem
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function toggleMode() {
            const body = document.body;
            const icon = document.getElementById('modeIcon');
            body.classList.toggle('dark-mode');
            
            if(body.classList.contains('dark-mode')) {
                icon.classList.replace('bi-sun', 'bi-moon');
            } else {
                icon.classList.replace('bi-moon', 'bi-sun');
            }
        }
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
EOF
