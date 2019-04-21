# Minecraft Spigot
FROM alpine:latest

# Configuration
ENV LANG=C.UTF-8 \
	\
	MINECRAFT_VERSION=latest \
	MINECRAFT_HOME=/minecraft \
	SPIGOT_DOWNLOAD="https://hub.spigotmc.org/jenkins/job/BuildTools/82/artifact/target/BuildTools.jar" \
	SPIGOT_DOWNLOAD_HASH="273cb9ca052ac5b892bdcda46f9dfd57b413f40769a2490b2f278b3d7010c858"

# Run setup scripts.
COPY setup-tools.sh /tmp
RUN /tmp/setup-tools.sh

COPY setup-java.sh /tmp
RUN /tmp/setup-java.sh

COPY setup-spigot.sh /tmp
RUN /tmp/setup-spigot.sh

COPY setup-finalize.sh /tmp/finalize.sh
RUN /tmp/finalize.sh

# Run main.
COPY entry.sh /entry
ENTRYPOINT /entry

