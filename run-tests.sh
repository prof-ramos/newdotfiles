#!/bin/bash

# Define o diretório onde os testes estão localizados
TESTS_DIR="$(cd "$(dirname "$0")/tests" && pwd)"

# Executa o bats no diretório de testes
# O bats encontrará e executará automaticamente todos os arquivos *.bats
"$TESTS_DIR/libs/bats-core/bin/bats" "$TESTS_DIR"
