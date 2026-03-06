# Python 3.10 tabanlı güncel bir imaj kullanıyoruz
FROM python:3.10-slim

# Gerekli sistem kütüphanelerini yüklüyoruz (Ses işleme için lazım)
RUN apt-get update && apt-get install -y \
    ffmpeg \
    libsndfile1 \
    git \
    && rm -rf /var/lib/apt/lists/*

# Çalışma dizinini oluştur
WORKDIR /app

# Önce tüm dosyaları kopyala (Hata almamak için README ve src dahil)
COPY . .

# Bağımlılıkları yükle
RUN pip install --no-cache-dir --upgrade pip setuptools wheel
RUN pip install --no-cache-dir .

# Uygulamanın dış dünyaya açılacağı port
EXPOSE 7860

# Uygulamayı başlat (Chatterbox varsayılan başlatma komutu)
CMD ["python", "-m", "chatterbox"]
