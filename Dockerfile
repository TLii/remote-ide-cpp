# This image is used to run PHP IDEs (e.g. PhpStorm) in a containerized environment.
# Included: PHP, Composer, Helm, Docker CLI, SSH server, xdebug, phpunit

FROM tliin/debian-ide-base:latest
LABEL description="Containerized remote for C++ development"

USER root

# Install base tools
RUN apt-get install --no-install-recommends -y \
    make \
    build-essential \
    manpages-dev \
    gdb

## SETUP ADDITIONAL TOOLS ##


# FINISH WITH CHANGING USER
USER $IDE_UID