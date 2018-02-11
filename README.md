# Wireman v1.0 #

### Nginx-based TCP stream bridge ###

Run:

    $ docker run -d --net="network_to_listen" --rm symonsoft/wireman target_host_1:target_port_1:listen_port_1 ... target_host_N:target_port_N:listen_port_N

#### Examples: ####

1. Map all incoming connections coming to the host machine on port `8080` to `remoteserver.com:80`:

        $ docker run --net=host --rm symonsoft/wireman remoteserver.com:80:8080

2. Map all incoming connections coming to the host machine on port `8080` to the running container  named `container` on port `80` inside of `container_network`:

        $ docker run --net=container_network -p=8080:8080 --rm symonsoft/wireman container:80:8080

3. Map all incoming connections coming to the running container named `container` on port `8080` inside of `container_network` to `remoteserver.com:80`:

        $ docker run --net=container_network --name=container --rm symonsoft/wireman remoteserver:80:8080

Remember you can provide several mappings for the container:

    $ docker run --net=host --rm symonsoft/wireman remoteserver1.com:80:8081 remoteserver2.com:80:8082

Also, it's useful to substitute being debugged container from a compose stack redirecting all communication to externally debugged service server:

    version: '2'

    services:
        ...
        service_to_debug:
            image: symonsoft/wireman
            command: debug_service_server.com:80:8080
        ...
