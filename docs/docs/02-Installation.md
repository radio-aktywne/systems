---
slug: /install
title: Installation
---

## Installing on the target machine

Boot the target machine from [`NixOS` ISO](https://nixos.org/download.html#nixos-iso)
and run the following command:

```sh
sudo nixos-generate-config
```

Prepare host configuration based on
the generated `/etc/nixos/hardware-configuration.nix` file.
Put it in `hosts/$HOST` directory in the repository,
where `$HOST` is the name of the host device of your choice.
When you are ready, commit the changes to the repository.

Put the [`age`](https://github.com/FiloSottile/age)
private keys on the target machine either in `~/.config/sops/age/keys.txt`
or somewhere else with `SOPS_AGE_KEY_FILE` environment variable set.
The installation script will copy the keys to persistent storage.

Change the HOST variable to the name of the host configuration
you want to install and run:

<!-- markdownlint-disable line-length -->

```sh
sudo nix --experimental-features 'nix-command flakes' run "github:radio-aktywne/systems#${HOST}-install-script"
```

<!-- markdownlint-enable line-length -->

and then reboot the machine.
