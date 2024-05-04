## 🐋 Setup with a `Dev Container`

If you use [`Visual Studio Code`](https://code.visualstudio.com) as your editor
and you have [`Docker`](https://www.docker.com) compliant CLI installed,
you can use the [`Dev Container`](https://code.visualstudio.com/docs/remote/containers)
to get a development environment up and running quickly.

This way you don't have to install any specific dependencies on your local machine.
The whole development environment will be running inside a container.

If you open the project in `Visual Studio Code`,
you should be prompted to reopen the project in a `Dev Container`.
You can also click
[here](https://vscode.dev/redirect?url=vscode://ms-vscode-remote.remote-containers/cloneInVolume?url=https://github.com/radio-aktywne/systems)
or on the badge below to tell `Visual Studio Code`
to open the project in a `Dev Container`.

<div align="center">

[![Open in Dev Container](https://img.shields.io/static/v1?label=Dev%20Containers&message=Open&color=blue&logo=visualstudiocode)](https://vscode.dev/redirect?url=vscode://ms-vscode-remote.remote-containers/cloneInVolume?url=https://github.com/radio-aktywne/systems)

</div>

## ❄️ Setup with `Nix`

If you don't want to use the `Dev Container` setup,
you can also use [`Nix`](https://nixos.org) to setup your development environment.
`flake.nix` contains the configuration of development shells.
`Nix` will automatically install all dependencies and setup the environment for you.

All you need to do is have `Nix` installed and run the following command:

```sh
nix develop
```

or in case you don't have experimental features enabled globally:

```sh
nix --extra-experimental-features 'nix-command flakes' develop
```

This will drop you into a new shell with all dependencies installed.
If you want to exit the shell, just type `exit` or press `Ctrl + D`.

## 📁 Using `direnv`

If you have [`direnv`](https://direnv.net) installed,
and you run `direnv allow` in the project root,
you will automatically enter the development shell
whenever you enter the project directory.
Additionally, `direnv` will rebuild the development shell in background
whenever there are changes to files that are used to build the shell.

If you use the `Dev Container` setup,
you will have the `direnv` extension installed in `Visual Studio Code`.
This should automatically ask you to allow `direnv` when you open the project.

## 🟦 Using `Task`

This project uses [`Task`](https://taskfile.dev) to manage development tasks.
You can find all the tasks in `Taskfile.dist.yaml`.
You can create your own `Taskfile.yaml` to include your own tasks.

To see all available tasks, you can run:

```sh
task --list
```

If you use the `Dev Container` setup,
you will have the `Task` extension installed in `Visual Studio Code`.
This will allow you to run tasks from the editor.

## 🔄 Fetching template updates

The template can change over time.
To fetch the latest changes from the template,
make sure you have a clean working tree and
then run the following command:

```sh
task template
```

There might be conflicts if you have made changes to the templated files yourself.
I recommend that you choose to overwrite the files with the template changes
and then manually review the changes using `git`.

## 🧹 Using `Trunk`

This project uses [`Trunk`](https://trunk.io) to help with formatting and linting.
This way all developers use the same tools and configurations.

There are multiple ways in which you can use `Trunk`.
Here are the most common ones, using `Task`:

- `task fmt` - Run formatting on all changed files.
- `task lint` - Run linting on all changed files.

Linting is automatically run on every pull request and push to the `main` branch.
You can find the `GitHub Actions` workflow that does this in
[`.github/workflows/lint.yaml`](https://github.com/radio-aktywne/systems/blob/main/.github/workflows/lint.yaml).

If you use the `Dev Container` setup,
you will have the `Trunk` extension installed in `Visual Studio Code`.
`Trunk` will be set as the default formatter for all files,
so you can format with it by using any editor formatting features.

## 📄 Docs

This project uses [`Docusaurus`](https://docusaurus.io) to generate documentation.
The documentation is hosted on `GitHub Pages` and can be found
[here](https://radio-aktywne.github.io/systems).
All the documentation files are located in the `docs` directory.

To build and serve the documentation locally,
you can run the following command:

```sh
task docs
```

This will start a local server that will serve the documentation.

The documentation is automatically built and deployed to `GitHub Pages`
whenever a commit is pushed to the `main` branch.
You can find the `GitHub Actions` workflow that does this in
[`.github/workflows/docs.yaml`](https://github.com/radio-aktywne/systems/blob/main/.github/workflows/docs.yaml).

## 🙊 Secrets management

This project uses [`SOPS`](https://github.com/getsops/sops)
to manage secrets.
Secrets are encrypted using [`age`](https://github.com/FiloSottile/age)
keys and stored in the repository.

You need to have the age private key available on your development machine.
The best is to store it in `~/.config/sops/age/keys.txt` file.
However, you can put it anywhere you want,
just make sure to set the `SOPS_AGE_KEY_DIR` and `SOPS_AGE_KEY_FILE`
environment variables accordingly.

When you want to edit some secret file, just run:

```sh
task secret -- $FILE
```

where `$FILE` is the path to the file you want to edit.
This will use the age private key to decrypt the file
and open it in the editor specified by `EDITOR` environment variable.
When you are done editing the file,
the file will be encrypted so that you can safely commit it to the repository.

## 📺 Virtual machines

If you want to try out any host configuration in a virtual machine,
you can run:

```sh
task vm -- "$HOST"
```

where `$HOST` is the name of the target machine.

Due to difficult to understand issues with cross-compilation,
you can build the virtual machine only on the same architecture as the target machine.

If you are using X11, you might need to run the following command on your host
to allow the virtual machine to connect to your X server:

```sh
xhost +local:
```
