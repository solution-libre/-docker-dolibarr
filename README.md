# Dolibarr with Docker Compose

<!-- markdownlint-disable-next-line MD001 -->
#### Table of Contents

1. [Description](#description)
2. [Requirements](#requirements)
3. [Setup](#setup)
4. [Usage](#usage)
5. [Reference](#reference)
6. [Development](#development)
7. [Contributors](#contributors)

## Description

[Docker Compose](https://docs.docker.com/compose/) setup for starting [Dolibarr](https://www.dolibarr.org/)
with [Traefik](https://traefik.io/) by [Solution Libre].

The [main Compose file](https://usine.solution-libre.fr/docker/dolibarr/-/blob/main/dolibarr-docker/compose.yaml),
which is present in the `dolibarr-docker` folder, is a copy of the [Dolibarr](https://github.com/Dolibarr)
work that maintains great [Docker images of Dolibarr](https://github.com/Dolibarr/dolibarr-docker).

## Requirements

* [Traefik with Docker Compose](https://usine.solution-libre.fr/docker/traefik)

## Setup

```sh
cd /opt
git clone https://usine.solution-libre.fr/docker/dolibarr.git
cd dolibarr
cp -r .secrets.dist .secrets
cp dolibarr-docker/secrets/* .secrets/
```

Declare environment variables or copy the `.env.dist` to `.env` and adjust its values.

Change the value of the secrets in the `.secrets` folder.

Register a domain like 'dolibarr.domain.tld'.

## Usage

```sh
cd /opt/dolibarr
docker compose up -d
```

## Reference

See [REFERENCE.md](./REFERENCE.md)

## Development

[Solution Libre]'s repositories are open projects,
and community contributions are essential for keeping them great.

[Fork this repo on our GitLab](https://usine.solution-libre.fr/docker/dolibarr/-/forks/new) or
[on GitHub](https://github.com/solution-libre/docker-dolibarr/fork)

## Contributors

The list of contributors can be found at: <https://usine.solution-libre.fr/docker/dolibarr/-/graphs/main>

[Solution Libre]: https://www.solution-libre.fr
