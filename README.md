
# 🧬 Organización de archivos genómicos Bacillus

Este proyecto contiene dos scripts en Bash para organizar archivos genómicos, de CDS y de proteínas a partir de carpetas que contienen datos descargados por ensamblado (ej. `GCF_XXXXXXX.X`). 

## 📁 Estructura esperada

Cada carpeta `GCF_XXXXXXX.X` debe contener 3 archivos con nombres que incluyan:

- `"CDS"` → archivo con secuencias de **CDS** (ej: `cds_from_genomic.fna`)
- `"Bacillus"` → archivo genómico con nombre del organismo (ej: `GCF_XXXX_Bacillus_subtilis_genomic.fna`)
- *ni* `"CDS"` *ni* `"Bacillus"` → archivo de **proteínas** (ej: `protein.faa`)

---

## ⚙️ Script 1: `renombrar_archivos.sh`

### 📌 Función:
Renombra los 3 archivos en cada carpeta `GCF_*`, anteponiendo un nombre basado en las **primeras 6 palabras** de la primera línea del archivo genómico.

### 🔍 Lógica de identificación:
- Archivos con `"CDS"` en el nombre → archivo de CDS.
- Archivos con `"Bacillus"` en el nombre → archivo genómico.
- Archivos sin `"CDS"` ni `"Bacillus"` → archivo de proteínas.

### 🧪 Ejemplo de renombrado:
Archivo original:
```
cds_from_genomic.fna
```

Primera línea del archivo genómico:
```
>NZ_CP006620.1 Bacillus subtilis subsp. subtilis str. 168 chromosome
```

Archivo renombrado:
```
NZ_CP006620.1_Bacillus_subtilis_subsp._subtilis_str._cds_from_genomic.fna
```

### ▶️ Uso:
```bash
chmod +x renombrar_archivos.sh
./renombrar_archivos.sh
```

---

## ⚙️ Script 2: `mover_archivos.sh`

### 📌 Función:
Mueve los archivos renombrados desde cada carpeta `GCF_*` a 3 carpetas globales según su tipo:

- `*_cds_from_genomic.fna` → `cds/`
- `*_genomic.fna` → `genomic/`
- `*_protein.faa` → `protein/`

Las carpetas se crean automáticamente si no existen.

### ▶️ Uso:
```bash
chmod +x mover_archivos.sh
./mover_archivos.sh
```

---

## ✅ Recomendación de ejecución

1. Renombra todos los archivos:

   ```bash
   ./renombrar_archivos.sh
   ```

2. Luego, mueve todos los archivos renombrados:

   ```bash
   ./mover_archivos.sh
   ```

---

## 📂 Resultado esperado

Después de ejecutar ambos scripts, tendrás:

```
cds/
  ├── NZ_CP006620.1_Bacillus_subtilis_subsp_subtilis_str_cds_from_genomic.fna
genomic/
  ├── NZ_CP006620.1_Bacillus_subtilis_subsp_subtilis_str_GCF_XXXXX_genomic.fna
protein/
  ├── NZ_CP006620.1_Bacillus_subtilis_subsp_subtilis_str_protein.faa
```

---

## 🧠 Autor

Francisco Astorga, automatizado con ❤️ por ChatGPT.
