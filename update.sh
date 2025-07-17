#!/usr/bin/env bash

# update.sh
# Script para atualizar os dotfiles no repositório a partir dos arquivos locais
# e para atualizar o Brewfile.

# Garante que o script pare em caso de erro
set -e

# --- Variáveis ---
REPO_DIR="$HOME/Dotfiles"
CONFIG_DIR="$REPO_DIR/config"

# Mapeamento de "arquivo no home" para "arquivo no repo"
declare -A dotfiles_map=(
  ["$HOME/.zshrc"]="$CONFIG_DIR/zsh/.zshrc"
  ["$HOME/.gitconfig"]="$CONFIG_DIR/git/.gitconfig"
  ["$HOME/.gitignore_global"]="$CONFIG_DIR/git/.gitignore_global"
  ["$HOME/.config/zellij/config.kdl"]="$CONFIG_DIR/terminal/zellij/config.kdl"
  ["$HOME/.config/ghostty/config"]="$CONFIG_DIR/terminal/ghostty/config"
  ["$HOME/.cursor/settings.json"]="$CONFIG_DIR/editor/Cursor/settings.json"
  ["$HOME/.cursor/keybindings.json"]="$CONFIG_DIR/editor/Cursor/keybindings.json"
)

# --- Funções ---
echo_info() {
  echo "INFO: $1"
}

echo_success() {
  echo "SUCCESS: $1"
}

# --- Lógica Principal ---
echo_info "Iniciando a atualização dos dotfiles no repositório..."

# 1. Copia os arquivos de configuração do home para o repositório
for home_path in "${!dotfiles_map[@]}"; do
  repo_path="${dotfiles_map[$home_path]}"
  
  if [ -f "$home_path" ]; then
    echo_info "Copiando '$home_path' para '$repo_path'"
    # Garante que o diretório de destino exista no repositório
    mkdir -p "$(dirname "$repo_path")"
    cp "$home_path" "$repo_path"
  else
    echo "AVISO: Arquivo '$home_path' não encontrado. Pulando."
  fi
done

echo_success "Dotfiles do repositório atualizados."

# 2. Atualiza o Brewfile
echo_info "Atualizando o Brewfile com os pacotes instalados..."
if command -v brew &> /dev/null; then
  brew bundle dump --file="$REPO_DIR/Brewfile" --force
  echo_success "Brewfile atualizado com sucesso!"
else
  echo "ERRO: Homebrew não encontrado. Não foi possível atualizar o Brewfile."
  exit 1
fi

echo ""
echo "-----------------------------------------------------------------"
echo "Lembrete Importante:"
echo "Os arquivos de configuração e o Brewfile foram atualizados."
echo "Revise as mudanças com 'git status' e 'git diff'."
echo "É importante que você faça um commit organizado para manter"
echo "o histórico de alterações claro e coeso."
echo ""
echo "Exemplo de commit:"
echo "git add ."
echo "git commit -m \"feat(zsh): atualiza aliases e funções\""
echo "-----------------------------------------------------------------"
