#!/bin/bash

# Carpeta donde están los archivos de audio
AUDIO_DIR="/app/audio"

# Verificar que exista al menos un archivo MP3
INPUT_FILE=$(ls "$AUDIO_DIR"/*.mp3 2>/dev/null | head -n 1)
if [ -z "$INPUT_FILE" ]; then
    echo "Error: No se encontró ningún archivo MP3 en $AUDIO_DIR"
    exit 1
fi

OUTPUT_FILE="${AUDIO_DIR}/salida.txt"

# Convertir MP3 a WAV
echo "Convirtiendo $INPUT_FILE a formato WAV..."
ffmpeg -i "$INPUT_FILE" -ar 16000 -ac 1 "${AUDIO_DIR}/audio.wav"

# Transcribir audio usando whisper
echo "Transcribiendo audio..."
whisper "${AUDIO_DIR}/audio.wav" --output_format txt --output_dir "$AUDIO_DIR" > /dev/null 2>&1

# Renombrar la transcripción generada
if [ -f "${AUDIO_DIR}/audio.txt" ]; then
    mv "${AUDIO_DIR}/audio.txt" "$OUTPUT_FILE"
    echo "Transcripción completa. El texto se encuentra en $OUTPUT_FILE"
else
    echo "Error: no se pudo generar la transcripción."
    exit 1
fi

# Limpiar archivos temporales
rm -f "${AUDIO_DIR}/audio.wav"

