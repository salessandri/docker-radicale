# Radicale on Docker

[![Docker Stars](https://img.shields.io/docker/stars/salessandri/radicale.svg)](https://hub.docker.com/r/salessandri/radicale/)
[![Docker Pulls](https://img.shields.io/docker/pulls/salessandri/radicale.svg)](https://hub.docker.com/r/salessandri/radicale/)
[![ImageLayers](https://images.microbadger.com/badges/image/salessandri/radicale.svg)](https://microbadger.com/images/salessandri/radicale)

Unopinionated and tiny docker image to run [Radicale](https://radicale.org/).

## Quick Start

```
docker run -p5232:5232 salessandri/radicale:latest --config "" --server-hosts 0.0.0.0:5232
```

This will launch a Radicale instance accessible through [http://localhost:5232](http://localhost:5232).
All the data will be ephemeral and no authentication is performed.

## Better Way

A more serious approach to running a Radicale server first requires to create a folder structure in the host, something like this:

```
radicale-data/
├── config/
│   ├── radicale.conf
│   └── users
└── data/
```

Follow the guideline in [Radicale's Website](https://radicale.org/v3.html#configuration) to determine what to put in the `radicale.conf` file.

A potential configuration would look like:

```ini

[server]
# Bind all addresses - Necessary for allowing connections outside the docker container
hosts = 0.0.0.0:5232, [::]:5232
dns_lookup = False

[auth]
type = htpasswd
htpasswd_filename = /radicale/config/users
htpasswd_encryption = bcrypt

[storage]
filesystem_folder = /radicale/data
```

The `radicale-data/config/users` file should be managed using `htpasswd`.

To run the container you would invoke docker with:

```
docker run -p5232:5232 \
    -v<path>/radicale-data/config:/radicale/config:ro \
    -v<path>/radicale-data/data:/radicale/data  \
    salessandri/radicale:latest --config "/radicale/config/radicale.conf"
```
