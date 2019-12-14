# Minecraft/Server

A docker container for running a [Spigot](https://www.spigotmc.org/) server.



## Dockerfile Information

- Alpine Linux Base
- Alpine OpenJDK 11



## Usage

**Setup:**

This will automatically download and run Spigot BuildTools.

```shell
docker build -t "minecraft" .
```



**Storage:**

This will create a persistent-storage volume for the server.

```shell
docker volume create "minecraft-xxx"
```



**Running:**

```shell
docker run -d \
	--name "minecraft" \
	--user "minecraft" \
	--mount "source=minecraft-xxx,target=/minecraft" \
	-p 25565:25565
	minecraft [args]
```



**Arguments:**

|Long|Short|Example|Description|
|:--|:--|:--|:--|
|--memory|-m|-m 1G|Sets the Java memory limit.|
|--memory:min|-m:m|-m:m 256M|Sets the lower Java memory limit.|
|--memory:max|-m:M|-m:M 2G|Sets the upper Java memory limit.|
|--recommended|-+|-+|Sets recommended Java options.|
|--args:jvm|-a:j|-a:j '\[' -Xmx1G -Xms128M '\]'|Passes through one or more Java Virtual Machine options.|
|--args:server|-a:s|-a:s nogui|Passes through one or more Minecraft server options.|
