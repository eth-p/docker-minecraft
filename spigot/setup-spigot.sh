#!/usr/bin/env bash
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"
set -e

# Set up directories.
MINECRAFT_BIN="/usr/share/minecraft"
TEMP="$(mktemp -d)"
cd "$TEMP"

mkdir -p "$MINECRAFT_BIN"
mkdir -p "$MINECRAFT_HOME"

# Download Spigot build tools.
build_state "Downloading Spigot build tools."
curl -L -o \
	"$TEMP/BuildTools.jar" \
	"$SPIGOT_DOWNLOAD"

# Compare hashes.
[ "$(sha256sum "$TEMP/BuildTools.jar" | cut -d' ' -f1)" = "$SPIGOT_DOWNLOAD_HASH" ] || {
	echo "MISMATCHED BUILDTOOLS SHA256SUM! ABORTING."
	exit 100
}

# Run build tools.
build_state "Running Spigot build tools."
build_note  SLOW
echo "Building for Minecraft version '${MINECRAFT_VERSION}'."
java -Xmx1024M -jar "BuildTools.jar" --rev "$MINECRAFT_VERSION"

# Move server software.
build_state "Copying server software..."
find -maxdepth 1 -name "spigot-*.jar" -exec "mv" "{}" "$MINECRAFT_BIN/spigot-server.jar" ";"
find -maxdepth 1 -name "craftbukkit-*.jar" -exec "mv" "{}" "$MINECRAFT_BIN/bukkit-server.jar" ";"
find -maxdepth 1 -name "minecraft-*.jar" -exec "mv" "{}" "$MINECRAFT_BIN/minecraft-server.jar" ";"

# Setup server software.
echo "eula=true" > "$MINECRAFT_HOME/eula.txt"

# Clean up.
rm -rf "$TEMP"
