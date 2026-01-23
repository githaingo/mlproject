# Utilisez une image avec CUDA pré-installée
#FROM nvidia/cuda:12.1.1-runtime-ubuntu22.04
# Remplacer runtime par runtime + cuDNN
FROM nvidia/cuda:12.1.1-cudnn8-runtime-ubuntu22.04

# Pour voir les logs immédiatement
ENV PYTHONUNBUFFERED=1
ENV DEBIAN_FRONTEND=noninteractive

# Dossier de travail dans le container
WORKDIR /app

# Installation minimale
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    git \
    python3-pip \
    python3-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/* \
    && ln -s /usr/bin/python3 /usr/bin/python

# Copier les fichiers
COPY requirements.txt setup.py ./
COPY src/ ./src/

# Installer pip et les dépendances
RUN pip install --no-cache-dir --upgrade pip setuptools wheel && \
    pip install --no-cache-dir -r requirements.txt && \
    pip install --no-cache-dir -e .

# Créer utilisateur
RUN useradd -m -u 1000 devuser && \
    mkdir -p data models notebooks && \
    chown -R devuser:devuser /app

USER devuser

CMD ["python", "-c", "print('✅ mlproject ready!')"]