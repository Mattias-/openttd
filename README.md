# OpenTTD docker container image

[mattias/openttd on Docker Hub](https://hub.docker.com/r/mattias/openttd/)

## Usage
Start dedicated server with a new game:
```
docker run -p 3979:3979/tcp -p 3979:3979/udp  mattias/openttd
```

To announce an internet game on the server list add `-p 3978:3978`

New game with custom config:
```
docker run -p 3979:3979/tcp -p 3979:3979/udp -v "$PWD"/openttd.cfg:/root/.openttd/openttd.cfg:ro mattias/openttd
```

Resume a save game:
```
docker run -p 3979:3979/tcp -p 3979:3979/udp -v openttd:/root/.openttd mattias/openttd -g /root/.openttd/save/autosave/exit.sav
```

### Server configuration

Here are some of my favourite settings. Read more about them in the [OpenTTD wiki](https://wiki.openttd.org/Openttd.cfg).

```ini
[difficulty]
industry_density = 4
number_industries = 2
number_towns = 2
quantity_sea_lakes = 2
terrain_type = 3

[game_creation]
town_name = swedish
starting_year = 1950
tgen_smoothness = 3
map_x = 9
map_y = 9

[network]
pause_on_join = false
server_advertise = true
lan_internet = 0
server_password = hunter2
rcon_password = supersecret
server_name = My server
min_active_clients = 1
```

## Similar projects

https://github.com/luaduck/docker_openttd
https://hub.docker.com/r/bateau/openttd/
