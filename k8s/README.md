# Running an OpenTTD server on Kubernetes

To get started you need a copy of your favorite `openttd.cfg` file.

Create a configmap with your OpenTTD config.
```
kubectl create configmap openttd-config-1 --from-file=../openttd.cfg
```

Run OpenTTD as a StatefulSet.
```
kubectl apply -f openttd-statefulset.yml
```


## The curious case about UDP and TCP Services

To be able to connect and play on the server we need to be able to reach it over both TCP and UDP on port 3979. Kubernetes doesn't support services that expose both TCP and UDP for the same port. The solution is to use the same load balancer for these two services.

These services of type `LoadBalancer` need to use the same ip address.
In GCP you'd allocate a static ip and set that to be the `loadBalancerIP` in both services.

After modifying `loadBalancerIP` create the services with:
```
kubectl apply -f openttd-tcp-service.yml
kubectl apply -f openttd-udp-service.yml
```

# TODO
Advertising the game on the [public server list](https://www.openttd.org/en/servers), and the in-game server list doesn't work. This case is filed under inactive investigation :smile_cat:.
