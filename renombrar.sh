#!/bin/bash

# Evita que el script se borre si se ejecuta en la raíz del proyecto
if [ "$PWD" = "/home/tromvn/Documentos/AWS" ]; then
  echo "Error: No ejecutes este script en la raíz."
  exit 1
fi

for f in *; do
  # Evita renombrar este propio script
  if [ "$f" = "renombrar.sh" ]; then
    continue
  fi

  # Evita renombrar carpetas
  if [ -d "$f" ]; then
    continue
  fi

  # Cambia el nombre correctamente sin duplicar la extensión
  mv "$f" "${f%.png}.png"
done

echo "Operación exitosa. Autodestruyendo"

# --- Autoeliminación al finalizar ---
trap 'rm -f -- "$0"' EXIT
