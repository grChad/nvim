<p align="center">
    <img src="https://github.com/grChad/my-assets/blob/main/config-nvim/intro-nvim.webp" />
</p>

<p align="center">
    Mi Configuración de NeoVim para cualquiera que le guste.
</p>

## Requisitos

- NeoVim 0.9 o nightly, para _Fedora_ ve [**aquí**](https://github.com/grChad/my-dotfiles#neovim-)
- Una fuente con soporte de Glyphos: [_nert-fonts_](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts)
- [_ripgrep_](https://github.com/BurntSushi/ripgrep) para Telescope (opcional)
- [_NodeJs_](https://nodejs.org/en) para descargar algunos de los servidores. Tengo una guia de como instalarlo con _fnm_ [**aquí**](https://github.com/grChad/my-dotfiles/blob/main/other-settings/node.md)
- Y otros recomendados como: git, make, pip, npm y cargo instalados en tu sistema.

## Instalar

Antes de iniciar, asegúrate de tener tu sistema actualizado, dejare un comando para _Fedora_. Para otras distribuciones sera _casi_ lo mismo.

```shell
sudo dnf update
```

Ahora asegúrate de hacer una copia de tu Configuración actual. Y eliminar los siguientes directorios con el siguiente comando:

```bash
rm -rf ~/.local/share/nvim/ ~/.local/state/nvim/ ~/.cache/nvim/ ~/.config/nvim/
```

Ahora si podemos instalar, use el siguiente comando comando:

```bash
git clone https://github.com/grChad/nvim.git ~/.config/nvim --depth 1 && cd ~/.config/nvim/ && nvim init.lua
```

## Posibles problemas

Es posible que no todo salga según lo planeado y puedan surgir algunos problemas al utilizar _nvim_. Para evitar que sea demasiado detallado, me gustaría compartir dos problemas comunes junto con sus soluciones que me han sido de ayuda en situaciones similares.

<details>
    <summary>El porta-papeles</summary>

Esto se debe a la falta de soporte al porta-papeles o la incompatibilidad de algunas distribuciones. Principalmente con _X11_ o _Wayland_ y para cada caso hay una solución diferente.

Para usuarios del compositor gráfico X11 instalar `xclip`, ejemplo en **debian**:

```shell
sudo apt install xclip
```

Y para usuarios de Wayland instalar `wl-clipboard`, ejemplo en **Fedora**:

```shell
sudo dnf install wl-clipboard
```

</details>

<details>
    <summary>Compilación de TreeSitter</summary>

Me centrare en **Fedora**, si usas otra distribución podría darte alguna idea.

1. Si tienes este error:

   ```shell
   /usr/bin/ld: cannot find -lstdc++
   collect2: error: ld returned 1 exit status
   ```

   Se resuelve instalando lo siguiente:

   ```shell
   sudo dnf install libstdc++-static
   ```

2. Segundo error:

   ```shell
   Gcc error: gcc: error tryin to exec
   'cc1': execvp: No such file or directory
   ```

   La solución es instalar:

   ```shell
   sudo dnf install gcc-c++
   ```

</details>

## Atajos de teclado

_Neovim_ cuenta con atajos de teclado para mejorar la productividad. Algunos atajos útiles incluyen: guardar (:w), salir (:q), deshacer (:u) y buscar (: /).

Además, podemos personalizar tus propios atajos para adaptar Neovim a nuestras necesidades específicas. A continuación resumiré los atajos que uso a nivel general y para los plugins que tengo instalados.

La tecla **`<leader>`** que uso es _la tecla de espacio_ **`<Space>`**:

- **`<Up>`** hace referencia a la _flecha arriba_.
- **`<Down>`** hace referencia a la _flecha abajo_.

Plugin para comentar código:

Tanto en modo Normal y en Visual, para comentar en linea o toda una seleccion funciona con el atajo. **`<leader> + /`**.

<details>
    <summary>General</summary>

En modo Normal:

|      Comando       | Descripción                                                          |
| :----------------: | -------------------------------------------------------------------- |
| **`<leader> + w`** | Para escribir o guardar el archivo.                                  |
| **`<leader> + q`** | Para salir de nvim.                                                  |
| **`<leader> + y`** | Realiza una copia de todo el archivo.                                |
|      **`m`**       | Anula el highlight que se genera al realizar una busqueda `/` o `*`. |
|     **`<Up>`**     | Para hacer scroll hacia arriba.                                      |
|    **`<Down>`**    | Para hacer scroll haci abajo.                                        |
|   **`Alt + k`**    | Pava mover linea o lineas selecciondas hacia arriba..                |
|   **`Alt + j`**    | Para mover linea o lineas selecciondas hacia abajo.                  |
|   **`Ctrl + h`**   | Se posiciona en la ventana Izquierda.                                |
|   **`Ctrl + l`**   | Se posiciona en la ventana Derecha.                                  |
|   **`Ctrl + k`**   | Se posiciona en la ventana Superior.                                 |
|   **`Ctrl + j`**   | Se posiciona en la ventana Inferior.                                 |

En modo Insertar:

|       Comando       | Descripción                         |
| :-----------------: | ----------------------------------- |
|   **`Ctrl + b`**    | Cursor al inicio de la linea.       |
|   **`Ctrl + e`**    | Cursor al final de la linea.        |
| **`kj`** o **`KJ`** | Para hacer **`<ESC>`**              |
|   **`Ctrl + h`**    | Mueve el cursor hacia la Izquierda. |
|   **`Ctrl + l`**    | Mueve el cursor hacia la Derecha.   |
|   **`Ctrl + k`**    | Mueve el cursor hacia Arriba.       |
|   **`Ctrl + j`**    | Mueve el cursor hacia Abajo.        |

En modo Visual:

| Comando | Descripción                                      |
| :-----: | ------------------------------------------------ |
| **`<`** | Mueve seleccion un indentado hacia la Izquierda. |
| **`>`** | Mueve seleccion un indentado hacia la Derecha.   |

---

</details>

<details>
    <summary>Plugin para pestañas <strong>Barbar</strong></summary>

En modo Normal:

|      Comando       | Descripción                                        |
| :----------------: | -------------------------------------------------- |
| **`<leader> + x`** | Eliminar buffer                                    |
| **`<leader> + k`** | Navegar al buffer siguiente.                       |
| **`<leader> + j`** | Navegar al buffer anterior.                        |
|      **`,`**       | navegación por letras (cuando hay muchos buffers). |

---

</details>

<details>
    <summary>Toggle NvimTree</summary>

En modo Normal:

|      Comando       | Descripción                           |
| :----------------: | ------------------------------------- |
| **`<leader> + e`** | para alternar la ventana de NvimTree. |

Una vez dentro de NvimTree, esta tiene muchos atajos, seria recomendable visitar su repositorio de [Github](https://github.com/nvim-tree/nvim-tree.lua)

---

</details>

Telescope

En modo Normal:

|       Comando       | Descripción                             |
| :-----------------: | --------------------------------------- |
| **`<leader> + ff`** | Para buscar archivos en el proyecto.    |
| **`<leader> + fa`** | Busca archivos normales y ocultos.      |
| **`<leader> + fw`** | Busca palabras en todo el proyecto.     |
| **`<leader> + fb`** | Telescope buffers `navegar`             |
| **`<leader> + fh`** | Telescope help `documentación de ayuda` |
| **`<leader> + fo`** | busca archivos abiertos recientemente   |
