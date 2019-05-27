# Minecraft Spigot
FROM alpine:latest

# Configuration
ARG version=latest
ENV LANG=C.UTF-8 \
	\
	MINECRAFT_VERSION=$version \
	MINECRAFT_HOME=/minecraft \
	SPIGOT_DOWNLOAD="https://hub.spigotmc.org/jenkins/job/BuildTools/101/artifact/target/BuildTools.jar" \
	SPIGOT_DOWNLOAD_HASH="b27b683c9f30f22f56726af23350b9d6d870921443798b38adb341aead91d08c"

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
