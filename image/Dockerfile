# Minecraft Spigot
FROM alpine:latest

# Configuration
ARG version=latest
ENV LANG=C.UTF-8 \
	\
	MINECRAFT_VERSION=$version \
	MINECRAFT_HOME=/minecraft \
	SPIGOT_DOWNLOAD="https://hub.spigotmc.org/jenkins/job/BuildTools/103/artifact/target/BuildTools.jar" \
	SPIGOT_DOWNLOAD_HASH="67b989f24444c12c0417fa0e6c44ddd44d8bfa3b3811a61c1c7b586a592a8027"

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
ENTRYPOINT ["/entry"]
CMD []
