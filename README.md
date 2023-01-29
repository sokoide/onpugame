# README

## Dev Env

* pip

```sh
pip3 install 'gdtoolkit==3.*'
```

* VS Code
  * Install `godot-tools1 by Geequlim
  * Install `GDScript Formatter & Linter by Eddie Dover`
  * Set the followings in `settings.json`

    ```json
        // godot
        "godot_tools.editor_path": "/Applications/Godot_mono.app/Contents/MacOS/Godot",
        "[gdscript]": {
            "editor.formatOnSave": true
        },
    ```

* Godot
  * Configure external editor as written in <https://marketplace.visualstudio.com/items?itemName=geequlim.godot-tools>

    ```text
    1. Open the Editor Settings
    2. Select Text Editor > External
    3. Make sure the Use External Editor box is checked
    4. Fill Exec Path with the path to your VS Code executable
    On macOS, this executable is typically located at: /Applications/Visual Studio Code.app/Contents/MacOS/Electron
    5. Fill Exec Flags with {project} --goto {file}:{line}:{col}
    ```
