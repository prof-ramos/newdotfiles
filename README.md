# Dotfiles de Gabriel Ramos

![Licença](https://img.shields.io/github/license/gabrielramos/dotfiles?style=for-the-badge)
![Último Commit](https://img.shields.io/github/last-commit/gabrielramos/dotfiles?style=for-the-badge&color=a6e3a1)
![Feito para macOS](https://img.shields.io/badge/feito%20para-macOS-black?style=for-the-badge&logo=apple)

Repositório com minhas configurações de ambiente de desenvolvimento (`dotfiles`) para macOS. O objetivo é automatizar e padronizar a instalação e configuração das ferramentas que utilizo no dia a dia.

## 📖 Índice

- [O que são Dotfiles?](#o-que-são-dotfiles)
- [Conteúdo](#conteúdo)
- [Pré-requisitos](#pré-requisitos)
- [Como Usar](#como-usar)
  - [1. Backup (Opcional, mas recomendado)](#1-backup-opcional-mas-recomendado)
  - [2. Instalação](#2-instalação)
  - [3. Validação](#3-validação)
- [Atualizando os Dotfiles](#atualizando-os-dotfiles)
- [Estrutura do Repositório](#estrutura-do-repositório)
- [Arquitetura do Sistema](#arquitetura-do-sistema)
- [Licença](#licença)
- [Autor](#autor)

## 🤔 O que são Dotfiles?

Dotfiles são arquivos de configuração ocultos (que começam com um `.`, como `.zshrc` ou `.gitconfig`) presentes no diretório `home` do sistema. Eles controlam o comportamento de programas como o terminal, o editor de código, e outras ferramentas de linha de comando.

Manter os dotfiles em um repositório Git facilita o backup, a restauração e a sincronização das configurações entre diferentes máquinas.

## 📦 Conteúdo

Este repositório gerencia a configuração das seguintes ferramentas:

| Categoria      | Ferramenta/Aplicação                               |
| -------------- | -------------------------------------------------- |
| **Terminal**   | Ghostty, Zellij, Zsh                               |
| **Editor**     | Cursor (VS Code), Neovim (configuração básica)     |
| **Git**        | `.gitconfig` e `.gitignore_global`                 |
| **Gerenciador**| Homebrew                                           |

A lista completa de aplicações, fontes e CLIs instaladas via Homebrew pode ser encontrada no arquivo [`Brewfile`](./Brewfile).

## ⚙️ Pré-requisitos

- **macOS**: Os scripts foram projetados para este sistema.
- **Git**: Necessário para clonar o repositório.
- **Oh My Zsh**: O Zsh é configurado para usá-lo como base.

O **Homebrew** será instalado automaticamente pelo script `install.sh` caso não seja detectado no sistema.

## 🚀 Como Usar

Siga os passos abaixo para configurar seu ambiente.

### 1. Backup (Opcional, mas recomendado)

Antes de instalar, é uma boa prática fazer um backup dos seus arquivos de configuração existentes.

1.  Clone o repositório:
    ```bash
    git clone https://github.com/gabrielramos/dotfiles.git ~/Dotfiles
    ```
2.  Navegue até o diretório e execute o script de backup:
    ```bash
    cd ~/Dotfiles
    ./backup.sh
    ```
    Isso criará uma pasta de backup dentro do diretório `Dotfiles` com seus arquivos de configuração atuais.

### 2. Instalação

Com o backup feito, execute o script de instalação:
```bash
./install.sh
```

O script irá:
- Instalar o Homebrew (se necessário).
- Instalar todos os pacotes, aplicativos e fontes listados no `Brewfile`.
- Criar links simbólicos dos arquivos de configuração deste repositório para o seu diretório `home`.

### 3. Validação

Após a instalação, você pode executar o script de validação para verificar se todos os links simbólicos foram criados corretamente:

```bash
./validate.sh
```

## ✨ Atualizando os Dotfiles

Quando você fizer alterações nas suas configurações locais e quiser salvá-las no repositório, use o script `update.sh`:

```bash
./update.sh
```

Este script irá:
1.  Copiar seus arquivos de configuração locais (como `.zshrc`, `.gitconfig`, etc.) para este repositório.
2.  Atualizar o `Brewfile` com a lista mais recente de pacotes instalados.

Após executar o script, revise as mudanças e faça um commit para guardar o histórico.

## 📁 Estrutura do Repositório

- **`config/`**: Contém as configurações agrupadas por categoria.
- **`Brewfile`**: Declara as dependências gerenciadas pelo Homebrew.
- **`install.sh`**: Script que automatiza a instalação.
- **`update.sh`**: Script para atualizar os arquivos do repositório com as mudanças locais.
- **`backup.sh`**: Script para fazer backup das configurações existentes antes da instalação.
- **`validate.sh`**: Script para verificar a instalação.
- **`test-install.sh`**: Script para testar o processo de instalação.

## 🏛️ Arquitetura do Sistema

Para uma visão detalhada dos componentes, fluxos de dados e decisões de design que estruturam este projeto, consulte o documento de arquitetura.

➡️ **[Leia a documentação da Arquitetura](./ARQUITETURA.md)**

## 📜 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](./LICENSE) para mais detalhes.

---

Feito com ❤️ por **Gabriel Ramos**.
