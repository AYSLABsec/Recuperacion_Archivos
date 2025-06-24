#!/bin/bash

# Crear carpetas destino si no existen
mkdir -p cds genomic protein

# Recorre cada carpeta GCF_*
for dir in GCF_*; do
    if [[ -d "$dir" ]]; then
        echo "🚚 Moviendo archivos desde: $dir"
        cd "$dir" || continue

        # Mover archivos que terminen en cds_from_genomic.fna
        for f in *_cds_from_genomic.fna; do
            [[ -f "$f" ]] && mv "$f" ../cds/
        done

        # Mover archivos que terminen en genomic.fna
        for f in *_genomic.fna; do
            [[ -f "$f" ]] && mv "$f" ../genomic/
        done

        # Mover archivos que terminen en protein.faa
        for f in *_protein.faa; do
            [[ -f "$f" ]] && mv "$f" ../protein/
        done

        cd ..
    fi
done

echo "✅ Todos los archivos fueron movidos según su tipo (en minúsculas)."

