#!/bin/bash

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
