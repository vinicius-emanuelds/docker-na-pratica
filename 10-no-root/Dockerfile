FROM python:3.12-alpine

RUN addgroup -S docker_pratica && adduser -S admin -G docker_pratica

WORKDIR /app

RUN chown -R admin:docker_pratica /app

COPY requirements.txt .

RUN pip install --no-cache-dir  -r requirements.txt

COPY . /app

USER admin

ENTRYPOINT ["python3"]

CMD ["app.py"]

EXPOSE 5000

