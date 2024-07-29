# syntax=docker/dockerfile:1
FROM ubuntu-base:rolling
SHELL ["/bin/bash", "-c"]
USER root
ENV DEBIAN_FRONTEND=noninteractive
RUN \
	--mount=type=cache,target=/var/lib/apt/lists \
	--mount=type=cache,target=/var/cache/apt/archives \
	apt-get update \
	&& apt-get install make nodejs npm shellcheck devscripts locales-all build-essential debhelper neovim

# sets login user
ARG USER=root
# append .bashrc to load .config
RUN <<EOS cat | tee -a /${USER}/.bashrc
export XDG_CONFIG_HOME="/${USER}/.config"
source "\${XDG_CONFIG_HOME}/bash/.bashrc"
EOS
# symlink .config to workspace
ARG WORKSPACE_DIR
RUN ln -s "${WORKSPACE_DIR}/.config" "/${USER}/.config"
