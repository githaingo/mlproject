# Image officielle Python
FROM python:3.11.5-slim

# Pour voir les logs immédiatement
ENV PYTHONUNBUFFERED=1

# Dossier de travail dans le container
WORKDIR /app

# Copier d'abord les fichiers de dépendances
COPY requirements.txt setup.py ./
# Copier les codes 
COPY --chown=devuser:devuser src/ ./src/

# Installer les dépendances en une seule commande
RUN pip install --no-cache-dir -r requirements.txt && \
    pip install --no-cache-dir -e .



# Créer l'utilisateur non-root et les dossiers
RUN useradd -m -u 1000 devuser && \
    mkdir -p data models notebooks && \
    chown -R devuser:devuser /app

# Utiliser cet utilisateur
USER devuser

# Commande par défaut
CMD ["python", "-c", "print('✅ mlproject Dockerisé !')"]