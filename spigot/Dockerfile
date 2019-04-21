# Minecraft Spigot
FROM alpine:latest

# Configuration
ENV GLIBC_VERSION=2.28-r0 \
	\
	MINECRAFT_VERSION=latest \
	MINECRAFT_HOME=/minecraft \
	SPIGOT_DOWNLOAD="https://hub.spigotmc.org/jenkins/job/BuildTools/82/artifact/target/BuildTools.jar" \
	SPIGOT_DOWNLOAD_HASH="31f976713c2780df99377dd54317fe3a637018ea03bf61617736f3f23e162768" \
	\
	PATH=${PATH}:/opt/jdk/bin \
	LANG=C.UTF-8

# Run setup scripts.
COPY setup-*.sh "/tmp/"
COPY entry.sh "/entry.sh"

RUN /tmp/setup-tools.sh
RUN /tmp/setup-java.sh
RUN /tmp/setup-spigot.sh

# Run main.
ENTRYPOINT /entry.sh

