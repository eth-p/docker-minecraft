# Minecraft Spigot
FROM alpine:latest

# Configuration
ENV GLIBC_VERSION=2.28-r0 \
	\
	MINECRAFT_VERSION=latest \
	MINECRAFT_HOME=/minecraft \
	SPIGOT_DOWNLOAD="https://hub.spigotmc.org/jenkins/job/BuildTools/82/artifact/target/BuildTools.jar" \
	SPIGOT_DOWNLOAD_HASH="273cb9ca052ac5b892bdcda46f9dfd57b413f40769a2490b2f278b3d7010c858" \
	\
	JAVA_VERSION_MAJOR=8 \
	JAVA_VERSION_MINOR=191 \
	JAVA_VERSION_BUILD=12 \
	JAVA_PACKAGE=server-jre \
	JAVA_PACKAGE_HASH=2787e4a523244c269598db4e85c51e0c \
	JAVA_HOME=/opt/jdk \
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

