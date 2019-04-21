#!/usr/bin/env bash
set -e

# Set up directories.
MINECRAFT_BIN="/usr/share/minecraft"
TEMP="$(mktemp -d)"
cd "$TEMP"

mkdir -p "$MINECRAFT_BIN"
mkdir -p "$MINECRAFT_HOME"

# Download Spigot build tools.
curl -L -o \
	"$TEMP/BuildTools.jar" \
	"$SPIGOT_DOWNLOAD"

# Compare hashes.
[ "$(sha256sum "$TEMP/BuildTools.jar" | cut -d' ' -f1)" = "$SPIGOT_DOWNLOAD_HASH" ] || {
	echo "MISMATCHED BUILDTOOLS SHA256SUM! ABORTING."
	exit 100
}

# Run build tools.
java -Xmx1024M -jar "BuildTools.jar" --rev "$MINECRAFT_VERSION"

# Move server software.
find -maxdepth 1 -name "spigot-*.jar" -exec "mv" "{}" "$MINECRAFT_BIN/spigot-server.jar" ";"
find -maxdepth 1 -name "craftbukkit-*.jar" -exec "mv" "{}" "$MINECRAFT_BIN/bukkit-server.jar" ";"
find -maxdepth 1 -name "minecraft-*.jar" -exec "mv" "{}" "$MINECRAFT_BIN/minecraft-server.jar" ";"

# Setup server software.
echo "eula=true" > "$MINECRAFT_HOME/eula.txt"

# Clean up.
rm -rf "$TEMP"

