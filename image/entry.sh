#!/usr/bin/env bash
cd "$MINECRAFT_HOME"

# Defaults.
OPTS_JVM=()
OPTS_PROGRAM=()
OPT_VARIANT="spigot"

JVM_ARG_MEM_MIN=(512M)
JVM_ARG_MEM_MAX=(1024M)
HOST_CORES="$(grep -c ^processor /proc/cpuinfo)"
HOST_MEM="$(free -b | awk '$1 == "Mem:" { print int($2 / 1024 / 1014) }')"

# Parse arguments.
die() {
	printf "\x1B[31m%s\x1B[0m\n" "$1"
	exit 1
}

parse_key() {
	[[ "$bracket" = true ]] && return;
	
	value=""
	key="$(cut -d'=' -f1 <<< "$1")"
	if [[ "$1" =~ ^--[a-zA-Z0-9-]+= ]]; then
		value="$(cut -d'=' -f2- <<< "$1")"	
	fi
	
	case "$key" in
		-m|--memory)                                                        key="--memory"      ;;
		-s|--server)                                                        key="--server"      ;;
		-m:M|--memory:max)                                                  key="--memory:max"  ;;
		-m:m|--memory:min)                                                  key="--memory:min"  ;;
		-+|--recommended)                                                   key="--recommended" ;;
		-a:j|--args:jvm|--args:java|--jvm-args|--java-args)                 key="--args:jvm"    ;;
		-a:s|--args:server|--args:minecraft|--server-args|--minecraft-args) key="--args:server" ;;
		-c|--cpu)                                                           key="--cpu"         ;;
		
		*) die "Unknown argument '$key'" ;;
	esac
	
	if [[ -n "$value" ]]; then
		case "$key" in
			--args:*) die "Argument '$key' does not accept 'key=value' format." ;;
		esac
	else
		case "$key" in
			--recommended) commit_value "true" ;;
		esac
	fi
}

commit_value() {
	local V="$1"
	case "$key" in
		--memory)      JVM_ARG_MEM_MIN=("${V}"); JVM_ARG_MEM_MAX=("${V}")         ;;
		--memory:min)  JVM_ARG_MEM_MAX=("${V}")                                   ;;
		--memory:max)  JVM_ARG_MEM_MAX=("${V}")                                   ;;
		--cpu)         HOST_CORES="$V"                                            ;;
		--args:jvm)    OPTS_JVM+=("$V")                                           ;;
		--args:server) OPTS_PROGRAM+=("$V")                                       ;;
		--server)      {
			[[ -f "/usr/share/minecraft/${V}-server.jar" ]] || die "Unknown server type '$V'"
			OPT_VARIANT="$V"
		} ;;
		--recommended) {
			JVM_ARG_MEM_MAX="$(awk 'NR == 1 { print int($1 * 0.75) }' <<< "$HOST_MEM" )M"
			JVM_ARG_MEM_MIN="$(awk 'NR == 1 { print int($1 * 0.33) }' <<< "$HOST_MEM" )M"
			OPTS_JVM+=(
				-XX:+UseG1GC -XX:+UseStringDeduplication 
				-XX:+DisableExplicitGC -XX:MaxGCPauseMillis=10
				-XX:SoftRefLRUPolicyMSPerMB=10000 -XX:ParallelGCThreads="${HOST_CORES}"
			) 
		} ;;
	esac
}

key=""
value=""
bracket=false
for arg in "$@"; do
	if [[ "$bracket" = true ]]; then
		if [[ "$arg" != "]" ]]; then
			commit_value "$arg"
			continue
		fi
		
		bracket=false
	fi

	if [[ "${arg:0:1}" = "-" ]]; then
		parse_key "$arg"
		[[ -n "$value" ]] && commit_value "$value"
		continue
	fi
	
	if [[ "$arg" = "[" ]]; then
		bracket=true
		continue
	fi
	
	commit_value "$arg"
done

# Prepend arguments.
OPTS_JVM=("-Xms${JVM_ARG_MEM_MIN}" "-Xmx${JVM_ARG_MEM_MAX}" "${OPTS_JVM[@]}")

# Accept EULA.
echo "eula=true" > eula.txt

# Execute.
echo java "${OPTS_JVM[@]}" -jar "/usr/share/minecraft/${OPT_VARIANT}-server.jar" "${OPTS_PROGRAM[@]}"
exec java "${OPTS_JVM[@]}" -jar "/usr/share/minecraft/${OPT_VARIANT}-server.jar" "${OPTS_PROGRAM[@]}"
