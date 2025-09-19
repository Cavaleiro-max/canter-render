# Etapa 1: Builder com Ollama
FROM ollama/ollama:latest as builder

# Baixar modelos
RUN bash -c "ollama serve & sleep 10 && ollama pull openchat && ollama pull llama3:8b"

# Etapa 2: API Flask com modelos embutidos
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

# Copiar os modelos do Ollama
COPY --from=builder /root/.ollama /root/.ollama

# Diretório de trabalho
WORKDIR /app

# Copiar arquivos do projeto
COPY . .

# Instalar dependências Python
RUN pip install --upgrade pip && pip install -r requirements.txt

# Expor porta da API
EXPOSE 5000

# Rodar a API Flask com eventlet
CMD ["python", "app.py"]

