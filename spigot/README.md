# Minecraft/Server

A docker container for running a [Spigot](https://www.spigotmc.org/) server.



## Dockerfile Information

- Alpine Linux Base
- Oracle JDK 8



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
	minecraft
```

