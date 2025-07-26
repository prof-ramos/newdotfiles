# Dotfiles de Gabriel Ramos

![Licença](https://img.shields.io/github/license/gabrielramos/dotfiles?style=for-the-badge)
![Último Commit](https://img.shields.io/github/last-commit/gabrielramos/dotfiles?style=for-the-badge&color=a6e3a1)
![Feito para macOS](https://img.shields.io/badge/feito%20para-macOS-black?style=for-the-badge&logo=apple)

## 🎯 Descrição Executiva

Este repositório contém as configurações de ambiente de desenvolvimento (`dotfiles`) para macOS, gerenciadas para automação, padronização e portabilidade. O sistema é projetado para ser modular e de fácil manutenção, utilizando scripts para instalação, backup e atualização.

## 📖 Índice

- [Arquitetura do Sistema](#arquitetura-do-sistema)
- [Pré-requisitos](#pré-requisitos)
- [Instalação](#instalação)
- [Scripts Principais](#scripts-principais)
- [Estrutura do Repositório](#estrutura-do-repositório)
- [Licença](#licença)

## 🏛️ Arquitetura do Sistema

A arquitetura é baseada em um diretório `config` que armazena todas as configurações de forma categorizada. Scripts em `bash` orquestram a criação de links simbólicos, a instalação de dependências via `Homebrew` e a manutenção do ambiente.

Para uma visão detalhada dos componentes, fluxos de dados e decisões de design, consulte o documento de arquitetura.

➡️ **[Leia a documentação da Arquitetura](./ARQUITETURA.md)**

## ⚙️ Pré-requisitos

- **Sistema Operacional**: macOS
- **Git**: Para clonagem do repositório.
- **Oh My Zsh**: Utilizado como base para a configuração do Zsh.

O **Homebrew** será instalado automaticamente pelo script `install.sh` se não for detectado.

## 🚀 Instalação

### 1. Clone o Repositório

```bash
git clone https://github.com/gabrielramos/dotfiles.git ~/Dotfiles
cd ~/Dotfiles
```

### 2. Execute o Backup (Recomendado)

O script `backup.sh` cria um backup de suas configurações existentes em um diretório com timestamp.

```bash
./backup.sh
```

### 3. Execute a Instalação

O script `install.sh` instala as dependências do `Brewfile` e cria os links simbólicos necessários.

```bash
./install.sh
```

### 4. Valide a Instalação

O script `validate.sh` verifica se todos os links simbólicos foram criados corretamente.

```bash
./validate.sh
```

## 🛠️ Scripts Principais

| Script          | Descrição                                                                                             |
| --------------- | ----------------------------------------------------------------------------------------------------- |
| `install.sh`    | Instala o ambiente, incluindo dependências do Homebrew e links simbólicos.                            |
| `backup.sh`     | Realiza o backup das configurações existentes antes da instalação.                                    |
| `update.sh`     | Atualiza os arquivos do repositório com as configurações locais e o `Brewfile`.                         |
| `validate.sh`   | Verifica se os links simbólicos foram criados corretamente.                                           |
| `run-tests.sh`  | Executa os testes de regressão para garantir a estabilidade dos scripts.                                |

## 📁 Estrutura do Repositório

```
.
├── config/                # Configurações categorizadas
│   ├── editor/
│   ├── git/
│   ├── terminal/
│   └── zsh/
├── tests/                 # Testes automatizados
├── .gitignore
├── .gitmodules
├── ARQUITETURA.md         # Documentação da arquitetura
├── Brewfile               # Dependências do Homebrew
├── install.sh             # Script de instalação
├── backup.sh              # Script de backup
├── update.sh              # Script de atualização
├── validate.sh            # Script de validação
└── README.md              # Este arquivo
```

## 📜 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](./LICENSE) para mais detalhes.