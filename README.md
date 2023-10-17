# Remote IDE for C/C++

## General information

This is my personal remote IDE base for C/C++. It spins up basic Debian container with some additional packages installed. It has build_essentials and manpages-dev already installed. You can easily install additional libraries.

Basic features include an SSH server for connecting (you need to figure out connectivity depending on deployment strategy)

## How to use?

### Basics

You can use this container either locally as you please or remotely through SSH. The login password is either provided by you or set randomly at container startup. If you don't provide a password, it is randomly set *each time you start the container*. The random password is printed in container logs.
`.ssh/authorized_keys` is rebuilt on every container start. See below for persisting keys.

### Helm chart?

Not yet.

### Environment variables

- `$PASSWORD` sets the login password for the `vscode` user. User name can't be changed.
- You can provide a single ssh key through the environment variable `SSH-KEY`, if it happens to contain no illegal characters. This is not very well implemented, so use is discouraged.

### Special mount locations

- `/home/vscode/.ssh/authorized_keys.d`: Every file under this directory ending in .key will be included in .ssh/authorized_keys.
- `/home/vscode`: The home directory is persisted. Source code should be placed in a subdirectory.
- `/usr/local/etc/ssh`: The location of ssh(d) configuration. This is persisted to maintain ssh keys over instances.

### Custom scripting

You can add scripts to be run at container startup. `/home/vscode/setup.sh` is executed in the beginning of entrypoint, right after runlevel 1. `/home/vscode/start.sh` is executed at the end, right before final entrypoint scripting and the command passed to the container. You can use sudo to run commands with higher privileges.

### Extending container

You can also extend this image to suit your needs. I recommend against changing the docker-entrypoint.sh; instead, use provided runlevels 1–9 scripting directories under `/usr/local/bin/`. All files ending with .sh under these directories (e.g. `/usr/local/bin/entrypoint.d.1`) runlevels are executed at different points of docker-entrypoint, giving you a lot of control. See `/usr/local/bin/docker-entrypoint.sh` for details. Note that entrypoint is run as the user, so use sudo where necessary.