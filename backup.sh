#!/usr/bin/env bash

# backup.sh
# Script para fazer backup dos dotfiles existentes do usuário antes da instalação.

# --- Variáveis ---
# Encontra o diretório raiz do projeto (o diretório que contém este script)
PROJECT_ROOT="$(cd "$(dirname "$0")" && pwd)"

# Diretório de backup com timestamp para evitar sobreposições
BACKUP_DIR="$PROJECT_ROOT/backup_$(date +%Y-%m-%d_%H%M%S)"
CONFIG_DIR="$PROJECT_ROOT/config"

# Lista de arquivos e diretórios a serem copiados do repositório para o home do usuário.
# A estrutura é "caminho/no/repo:caminho/no/home"
declare -A symlinks=(
  ["$CONFIG_DIR/zsh/.zshrc"]="$HOME/.zshrc"
  ["$CONFIG_DIR/git/.gitconfig"]="$HOME/.gitconfig"
  ["$CONFIG_DIR/git/.gitignore_global"]="$HOME/.gitignore_global"
  ["$CONFIG_DIR/terminal/zellij/config.kdl"]="$HOME/.config/zellij/config.kdl"
  ["$CONFIG_DIR/terminal/ghostty/config"]="$HOME/.config/ghostty/config"
  ["$CONFIG_DIR/editor/Cursor/settings.json"]="$HOME/.cursor/settings.json"
  ["$CONFIG_DIR/editor/Cursor/keybindings.json"]="$HOME/.cursor/keybindings.json"
)

# --- Funções ---
echo_info() {
  echo "INFO: $1"
}

echo_success() {
  echo "SUCCESS: $1"
}

# --- Lógica Principal ---
echo_info "Iniciando o processo de backup..."

# Constrói uma lista de arquivos que realmente existem e precisam de backup
files_to_backup=()
for repo_path in "${!symlinks[@]}"; do
  home_path="${symlinks[$repo_path]}"
  if [ -e "$home_path" ]; then
    files_to_backup+=("$home_path")
  fi
done

# Verifica se a lista de arquivos para backup está vazia
if [ ${#files_to_backup[@]} -eq 0 ]; then
  echo_info "Nenhum dotfile encontrado para backup. Nenhuma ação necessária."
  exit 0
fi

# Cria o diretório de backup apenas se houver arquivos para fazer backup
mkdir -p "$BACKUP_DIR"
echo_info "Diretório de backup criado em: $BACKUP_DIR"

# Itera sobre a lista de arquivos existentes e faz o backup
for file_path in "${files_to_backup[@]}"; do
  echo_info "Fazendo backup de '$file_path' para '$BACKUP_DIR'"
  # Garante que a estrutura de diretórios exista no backup
  # A lógica aqui é um pouco simplificada, assumindo que os arquivos de config
  # não têm uma estrutura de diretórios complexa que precise ser replicada.
  cp -L "$file_path" "$BACKUP_DIR/"
done

echo_success "Processo de backup concluído!"
echo_info "Seus arquivos de configuração antigos estão salvos em: $BACKUP_DIR"
echo_info "Agora você pode executar o script 'install.sh' com segurança."
