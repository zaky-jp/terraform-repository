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
