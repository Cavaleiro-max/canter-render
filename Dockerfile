# Etapa única: API Flask com modelos Ollama embutidos
FROM python:3.11-slim

# Instalar dependências do sistema
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    build-essential \
    libjpeg-dev \
    libpng-dev \
    libopenjp2-7 \
    fonts-dejavu \
    fonts-liberation \
    && rm -rf /var/lib/apt/lists/*

# Instalar Ollama
RUN curl -fsSL https://ollama.com/install.sh | bash

# Copiar modelos pré-baixados
COPY .ollama /root/.ollama

# Definir diretório de trabalho
WORKDIR /app

# Copiar arquivos do projeto
COPY . .

# Instalar dependências Python
RUN pip install --upgrade pip && pip install -r requirements.txt

# Expor porta da API
EXPOSE 5000

# Rodar a API Flask com eventlet
CMD ["python", "app.py"]
