# Usa a imagem base do Python com Alpine para manter o container leve
FROM python:3.11.3-alpine3.18

# Definição do mantenedor
LABEL maintainer="vitoorgehlen@gmail.com"

# Variáveis de ambiente para otimizar o comportamento do Python
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PATH="/scripts:/venv/bin:$PATH"

# Instala dependências do sistema necessárias para pacotes Python compiláveis
RUN apk add --no-cache \
    gcc \
    musl-dev \
    python3-dev \
    libffi-dev \
    postgresql-dev \
    jpeg-dev \
    zlib-dev \
    build-base

# Copia o requirements.txt da raiz para o container
COPY requirements.txt /requirements.txt

# Copia os diretórios do projeto para o container
COPY djangoapp /djangoapp
COPY scripts /scripts

# Define o diretório de trabalho
WORKDIR /djangoapp

# Cria e configura o ambiente virtual
RUN python -m venv /venv && \
    /venv/bin/pip install --upgrade pip && \
    /venv/bin/pip install -r /requirements.txt

# Criação do usuário não root para maior segurança
RUN adduser --disabled-password --no-create-home duser && \
    mkdir -p /data/web/static /data/web/media && \
    chown -R duser:duser /venv /data/web/static /data/web/media /scripts && \
    chmod -R 755 /data/web/static /data/web/media && \
    chmod -R +x /scripts

# Expor a porta 8000 para comunicação
EXPOSE 8000

# Mudar para o usuário seguro
USER duser

# Executar o script de inicialização do container
CMD ["/scripts/commands.sh"]