#!/bin/bash

echo "Iniciando proceso de renombrado en carpetas 'src'..."

# Busca todas las carpetas llamadas 'src' dentro de la ruta actual
find . -type d -name "src" | while read -r carpeta_src; do
  
  echo "Procesando: $carpeta_src"
  
  # Entra a la carpeta src, ejecuta el renombrado y vuelve
  (
    cd "$carpeta_src" || exit
    
    # Recorre todos los archivos dentro del src actual
    for f in *; do
      # Si la carpeta está vacía, evita errores
      [ -e "$f" ] || continue
      
      # Evita renombrar subcarpetas si las hubiera
      [ -f "$f" ] || continue

      # Cambia el nombre agregando .png (sin duplicarlo si ya lo tiene)
      mv "$f" "${f%.png}.png"
    done
  )

done

echo "Operación exitosa. Todos los archivos en carpetas 'src' ahora son .png"
