#!/bin/bash

# Recorre todas las carpetas que empiecen con GCF_
for dir in GCF_*; do
    if [[ -d "$dir" ]]; then
        echo "📂 Procesando carpeta: $dir"

        cd "$dir" || continue

        # Archivos esperados
        CDS_FILE="cds_from_genomic.fna"
        GENOMIC_FILE=$(ls GCF* 2>/dev/null | head -n1)
        PROTEIN_FILE="protein.faa"

        if [[ ! -f "$CDS_FILE" || ! -f "$GENOMIC_FILE" || ! -f "$PROTEIN_FILE" ]]; then
            echo "⚠️ Archivos faltantes. Saltando $dir"
            cd ..
            continue
        fi

        # Obtener la primera línea del archivo genomic
        HEADER=$(head -n 1 "$GENOMIC_FILE")

        # Extraer las primeras 6 palabras, limpiar caracteres especiales y espacios
        ORG=$(echo "$HEADER" | cut -d' ' -f1-6 | tr ' ' '_' | tr -dc '[:alnum:]_.')

        if [[ -z "$ORG" ]]; then
            echo "❌ No se pudo extraer nombre del organismo"
            cd ..
            continue
        fi

        echo "🔤 Organismo detectado: $ORG"

        # Crear nuevos nombres
        NEW_CDS="${ORG}_cds_from_genomic.fna"
        NEW_GENOMIC="${ORG}_${GENOMIC_FILE}"
        NEW_PROTEIN="${ORG}_protein.faa"

        # Renombrar archivos
        mv "$CDS_FILE" "$NEW_CDS"
        mv "$GENOMIC_FILE" "$NEW_GENOMIC"
        mv "$PROTEIN_FILE" "$NEW_PROTEIN"

        echo "✅ Archivos renombrados en $dir"

        cd ..
    fi
done

