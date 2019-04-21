# Minecraft Spigot
FROM alpine:latest

# Configuration
ARG version=latest
ENV LANG=C.UTF-8 \
	\
	MINECRAFT_VERSION=$version \
	MINECRAFT_HOME=/minecraft \
	SPIGOT_DOWNLOAD="https://hub.spigotmc.org/jenkins/job/BuildTools/99/artifact/target/BuildTools.jar" \
	SPIGOT_DOWNLOAD_HASH="31f976713c2780df99377dd54317fe3a637018ea03bf61617736f3f23e162768"

# Run setup scripts.
COPY lib.sh /build/lib.sh
COPY setup-tools.sh /build/setup-tools.sh
RUN /build/setup-tools.sh

COPY setup-java.sh /build/setup-java.sh
RUN /build/setup-java.sh

COPY setup-spigot.sh /build/setup-spigot.sh
RUN /build/setup-spigot.sh

COPY setup-finalize.sh /build/finalize.sh
RUN /build/finalize.sh

# Run main.
COPY entry.sh /entry
ENTRYPOINT /entry

