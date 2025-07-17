#!/usr/bin/env bats

# Carrega as bibliotecas de suporte e asserções
load 'libs/bats-support/load'
load 'libs/bats-assert/load'

# --- Variáveis Globais ---
# Define o diretório raiz do projeto para que os scripts possam ser chamados de qualquer lugar
PROJECT_ROOT="$(cd "$(dirname "$BATS_TEST_FILENAME")/.." >/dev/null 2>&1 && pwd)"
# Define o caminho para o script que será testado
BACKUP_SCRIPT_PATH="$PROJECT_ROOT/backup.sh"

# --- Funções de Setup e Teardown ---

# A função `setup` é executada antes de cada teste
setup() {
  # Cria um diretório temporário que simulará o diretório HOME do usuário
  # Este é o nosso "sandbox"
  TEST_HOME="$(mktemp -d)"
  # Exporta a variável HOME para que todos os comandos subsequentes (~) a usem
  export HOME="$TEST_HOME"

  # Cria alguns arquivos de configuração "falsos" no nosso HOME de teste
  touch "$HOME/.zshrc"
  touch "$HOME/.gitconfig"
  mkdir "$HOME/.config"
  touch "$HOME/.config/nvim"
}

# A função `teardown` é executada depois de cada teste
teardown() {
  # Limpa o diretório sandbox para não deixar lixo no sistema
  rm -rf "$TEST_HOME"
}


# --- Testes ---

@test "backup.sh: deve criar um diretório de backup" {
  # Executa o script de backup diretamente.
  run "$BACKUP_SCRIPT_PATH"

  # Verifica se o script executou com sucesso (status 0)
  assert_success

  # Verifica se o diretório de backup foi criado dentro do diretório do projeto
  # Usamos um glob (*) para o timestamp
  local backup_dir_path="$PROJECT_ROOT/backup_*"
  run bash -c "ls -d $backup_dir_path"
  
  assert_success "O diretório de backup não foi encontrado."
}

@test "backup.sh: deve mover os arquivos de configuração para o diretório de backup" {
  # Executa o script
  run "$BACKUP_SCRIPT_PATH"
  assert_success

  # Encontra o nome do diretório de backup criado
  local backup_dir=$(ls -d "$PROJECT_ROOT"/backup_*)

  # Verifica se os arquivos "falsos" foram movidos para o diretório de backup
  assert_path_exist "$backup_dir/.zshrc"
  assert_path_exist "$backup_dir/.gitconfig"
}

@test "backup.sh: não deve fazer nada se não houver arquivos de configuração" {
  # Remove os arquivos "falsos" criados no setup
  rm "$HOME/.zshrc"
  rm "$HOME/.gitconfig"
  rm -rf "$HOME/.config"

  # Executa o script
  run "$BACKUP_SCRIPT_PATH"
  assert_success

  # Verifica se a saída do script contém a mensagem "Nenhum dotfile encontrado"
  assert_output --partial "Nenhum dotfile encontrado para backup."

  # Verifica que nenhum diretório de backup foi criado
  local backup_dir_path="$PROJECT_ROOT/backup_*"
  run bash -c "ls -d $backup_dir_path"
  
  # Esperamos que o comando `ls` falhe, pois nenhum diretório deve ser encontrado
  assert_failure
}
