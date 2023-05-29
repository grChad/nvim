<h1 align="center">
    Configuración de
    <img height="20px" src="https://github.com/grChad/my-assets/tree/main/dotfiles/icons/nvim-logo.png"/>
</h1>

## Requisitos

- NeoVim 0.9 o nightly
- Una fuente con soporte de Glyphos: [_nert-fonts_](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts)
- [_ripgrep_](https://github.com/BurntSushi/ripgrep) para Telescope, es (opcional)
- [_NodeJs_](https://nodejs.org/en) para descargar algunos de los servidores
- Y otros recomendados como: git, make, pip, npm y cargo instalados en tu sistema.

## Instalar

Antes de instalar asegúrate de hacer una copia de tu Configuración actual y eliminar los siguientes directorios:

```bash
rm -rf ~/.local/share/nvim/
rm -rf ~/.local/state/nvim/
rm -rf ~/.cache/nvim/
rm -rf ~/.config/nvim/
```

Luego ejecuta este comando:

```bash
git clone https://github.com/grChad/nvim.git ~/.config/nvim --depth 1 && cd ~/.config/nvim/ && nvim init.lua
```
