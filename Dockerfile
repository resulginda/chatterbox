FROM python:3.10-slim

# Ses işleme ve sistem kütüphaneleri
RUN apt-get update && apt-get install -y \
    ffmpeg \
    libsndfile1 \
    git \
    gcc \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Bağımlılıkları kopyala ve yükle
COPY pyproject.toml .
RUN pip install --no-cache-dir --upgrade pip setuptools wheel
RUN pip install --no-cache-dir .

# Proje dosyalarını kopyala
COPY . .

# Gradio'nun dışarıya açılması için gerekli ortam değişkeni
ENV GRADIO_SERVER_NAME="0.0.0.0"

EXPOSE 7860

# Uygulamayı başlatmak için chatterbox-tts'in kendi CLI komutunu kullanalım
CMD ["chatterbox", "launch"]
