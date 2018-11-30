#!/usr/bin/env bash
set -e

# Set up directories.
JDKS="$(dirname "$JAVA_HOME")"
TEMP="$(mktemp -d)"
cd "$TEMP"


# Download glibc.
for pkg in "glibc-${GLIBC_VERSION}" "glibc-bin-${GLIBC_VERSION}" "glibc-i18n-${GLIBC_VERSION}"; do
	curl -sSL "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/${pkg}.apk" -o "$TEMP/${pkg}.apk"
done

# Install glibc.
apk add --allow-untrusted "$TEMP"/*.apk

# Set up glibc.
( /usr/glibc-compat/bin/localedef --force --inputfile POSIX --charmap UTF-8 C.UTF-8 || true ) && \
	echo "export LANG=C.UTF-8" > /etc/profile.d/locale.sh

/usr/glibc-compat/sbin/ldconfig /lib /usr/glibc-compat/lib

# Clean up glibc install.
rm "$TEMP"/*


# Download Java.
mkdir -p "$JDKS"

JAVA_DL="https://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}/${JAVA_PACKAGE_HASH}/${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz"
echo "Downloading Java:"
echo "$JAVA_DL"

curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie" \
	-o "$TEMP/java.tar.gz" \
	"$JAVA_DL"

curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie" \
	-o "$TEMP/jce_policy-${JAVA_VERSION_MAJOR}.zip" \
	"http://download.oracle.com/otn-pub/java/jce/${JAVA_VERSION_MAJOR}/jce_policy-${JAVA_VERSION_MAJOR}.zip"

# Install Java.

stat "$TEMP/java.tar.gz"
gunzip "$TEMP/java.tar.gz"
tar -xf "$TEMP/java.tar" -C "$JDKS"
ln -s "$JDKS/jdk1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR}" "$JAVA_HOME"

cd "$JAVA_HOME"
ln -s "jre/bin" "bin"

# Set up Java.
sed -i 's/#networkaddress.cache.ttl=-1/networkaddress.cache.ttl=30/' "$JAVA_HOME/jre/lib/security/java.security"

# Trim Java.
rm -rf	"$JAVA_HOME/jre/plugin" \
		"$JAVA_HOME/jre/bin/javaws" \
		"$JAVA_HOME/jre/bin/jjs" \
		"$JAVA_HOME/jre/bin/orbd" \
		"$JAVA_HOME/jre/bin/pack200" \
		"$JAVA_HOME/jre/bin/policytool" \
		"$JAVA_HOME/jre/bin/rmid" \
		"$JAVA_HOME/jre/bin/rmiregistry" \
		"$JAVA_HOME/jre/bin/servertool" \
		"$JAVA_HOME/jre/bin/tnameserv" \
		"$JAVA_HOME/jre/bin/unpack200" \
		"$JAVA_HOME/jre/lib/javaws.jar" \
		"$JAVA_HOME/jre/lib/"deploy* \
		"$JAVA_HOME/jre/lib/desktop" \
		"$JAVA_HOME/jre/lib/"*javaxf* \
		"$JAVA_HOME/jre/lib/"*jfx* \
		"$JAVA_HOME/jre/lib/amd64/libdecora_sse.so" \
		"$JAVA_HOME/jre/lib/amd64/"libprism_*.so \
		"$JAVA_HOME/jre/lib/amd64/libfxplugins.so" \
		"$JAVA_HOME/jre/lib/amd64/libglass.so" \
		"$JAVA_HOME/jre/lib/amd64/libgstreamer-lite.so" \
		"$JAVA_HOME/jre/lib/amd64/"libjavafx*.so \
		"$JAVA_HOME/jre/lib/amd64/"libjfx*.so \
		"$JAVA_HOME/jre/lib/ext/jfxrt.jar" \
		"$JAVA_HOME/jre/lib/ext/nashorn.jar" \
		"$JAVA_HOME/jre/lib/oblique-fonts" \
		"$JAVA_HOME/jre/lib/plugin.jar"

# Clean up.
rm -rf "$TEMP"

