#!/usr/bin/env bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

PROJECT_ROOT="$(cd "$(dirname "$BATS_TEST_FILENAME")/.." >/dev/null 2>&1 && pwd)"
INSTALL_SCRIPT_PATH="$PROJECT_ROOT/install.sh"

setup() {
  TEST_HOME="$(mktemp -d)"
  export HOME="$TEST_HOME"
  
  mkdir -p "$PROJECT_ROOT/config/zsh/.zsh"
  touch "$PROJECT_ROOT/config/zsh/.zshrc"
  mkdir -p "$PROJECT_ROOT/config/editor/nvim"
  mkdir -p "$PROJECT_ROOT/config/editor/Cursor"
  mkdir -p "$PROJECT_ROOT/config/terminal/ghostty"
  mkdir -p "$PROJECT_ROOT/config/terminal/zellij"
  mkdir -p "$PROJECT_ROOT/config/git"
  touch "$PROJECT_ROOT/config/git/.gitignore_global"
  touch "$PROJECT_ROOT/config/git/.gitconfig"
}

teardown() {
  rm -rf "$TEST_HOME"
}

@test "install.sh: deve criar links simbólicos para os arquivos de configuração" {
  run bash -c "source '$INSTALL_SCRIPT_PATH'"

  assert_success
  assert_symlink "$HOME/.zshrc"
}

@test "install.sh: deve copiar o diretório .zsh" {
  run bash -c "source '$INSTALL_SCRIPT_PATH'"

  assert_success
  assert_path_exist "$HOME/.zsh"
}

@test "install.sh: deve copiar as configurações do editor" {
  run bash -c "source '$INSTALL_SCRIPT_PATH'"

  assert_success
  assert_path_exist "$HOME/.config/nvim"
  assert_path_exist "$HOME/.config/Cursor"
}

@test "install.sh: deve copiar as configurações do terminal" {
  run bash -c "source '$INSTALL_SCRIPT_PATH'"

  assert_success
  assert_path_exist "$HOME/.config/ghostty"
  assert_path_exist "$HOME/.config/zellij"
}

@test "install.sh: deve copiar a configuração do git" {
  run bash -c "source '$INSTALL_SCRIPT_PATH'"

  assert_success
  assert_path_exist "$HOME/.gitignore_global"
  assert_path_exist "$HOME/.gitconfig"
}
