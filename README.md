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
