# DCW-exporter

A exporter to DCW [dockcheck-web](https://github.com/Palleri/DCW)
DCW-exporter will trigger when main DCW is running update check.

## Dependencies:
[regclient/regctl](https://github.com/regclient/regclient) (Licensed under Apache-2.0 License)


----

docker-compose.yml
```yml
version: '3.2'
services:
  dcw-exporter:
    container_name: dcw-exporter
    image: 'palleri/dcw-exporter:latest'
    restart: unless-stopped
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock:ro
      - /etc/localtime:/etc/localtime:ro
    environment:
      TOKEN: superSecretPassw0rd                        // required // Main DCW token
      MAIN_DCW: 192.168.1.5                             // required // Ip address to the main DCW
      HTTP_PROXY: "http://proxy.homelab.net:3128"       // optional
      HTTPS_PROXY: "http://proxy.homelab.net:3128"      // optional
      EXCLUDE: "nginx,plex,prowlarr"                    // optional // Exclude containers from being checked for updates
```

# Security concern
For more security add the :ro to volumes docker.sock

Use with care, make sure you keep this container safe and do not publish on the internet.


# Notifications
This image use [apprise](https://github.com/caronc/apprise) for notifications

### Environment variables
Set `EXCLUDE: "nginx,plex,prowlarr"` if you want to exclude containers from being checked for updates
Use the name on each container in comma separated variable

Set `MAIN_DCW: 192.168.1.5` ip address to the main DCW

Set `TOKEN: superSecretPassw0rd` to the same password in DCW

-------


* Contributors
  - [Mag37](https://github.com/Mag37) 👑
  - [t0rnis](https://github.com/t0rnis) 🪖🐛
