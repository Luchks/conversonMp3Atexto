# Usar una imagen base de Python
FROM python:3.9-slim

# Establecer la fecha manualmente (ajustar la fecha y hora según sea necesario)
#RUN date -s "2024-12-06 19:15:00"

# Instalar ffmpeg
RUN apt-get update && apt-get install -y ffmpeg && rm -rf /var/lib/apt/lists/*

# Instalar whisper
RUN pip install whisper

# Crear el directorio de trabajo
WORKDIR /app

# Copiar el script al contenedor
COPY convertir_audio.sh /app/convertir_audio.sh

# Dar permisos de ejecución al script
RUN chmod +x /app/convertir_audio.sh

# Exponer el volumen donde se almacenan los archivos de audio
VOLUME ["/app/audio"]
