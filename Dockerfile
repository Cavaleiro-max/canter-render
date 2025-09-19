FROM python:3.11-slim

WORKDIR /app
COPY . /app

# Instalar dependências do sistema
RUN apt-get update && apt-get install -y curl

# Instalar Ollama
RUN curl -fsSL https://ollama.com/install.sh | sh

# Baixar modelos
RUN ollama pull openchat
RUN ollama pull llama3:8b

# Instalar dependências Python
RUN pip install --upgrade pip && pip install -r requirements.txt

EXPOSE 5000
CMD ["python", "app.py"]

