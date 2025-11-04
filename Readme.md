# Official FeelingSurfViewer Docker image

[![Docker Stars](https://img.shields.io/docker/stars/feelingsurf/viewer.svg)](https://hub.docker.com/r/feelingsurf/viewer/)
[![Docker Pulls](https://img.shields.io/docker/pulls/feelingsurf/viewer.svg)](https://hub.docker.com/r/feelingsurf/viewer/)

The official FeelingSurf app in a container is [available on Docker Hub](https://hub.docker.com/r/feelingsurf/viewer/).

FeelingSurfViewer is also available as a regular Desktop app at [FeelingSurf](https://www.feelingsurf.fr/surf#app-download-modal).

## Quick Start

```bash
docker run -d \
  -e access_token=<YOUR_SECRET_ACCESS_TOKEN> \
  --tmpfs /tmp \
  --tmpfs /dev/shm \
  feelingsurf/viewer:stable
```

**Disclaimer:** Never share your access token as it allows full access to your FeelingSurf account.

## Environment Variables

| Variable       | Required | Description                                        |
|----------------|----------|----------------------------------------------------|
| `access_token` | Yes      | Your FeelingSurf access token for authentication.  |

## Docker Compose Examples

### Single Container

Create a `docker-compose.yml` file:

```yaml
services:
  viewer:
    image: feelingsurf/viewer:stable
    environment:
      - access_token=${ACCESS_TOKEN}
    restart: unless-stopped
    tmpfs:
      - /tmp
      - /dev/shm
    logging:
      driver: "json-file"
      options:
        max-size: "10m"
        max-file: "3"
```

Create a `.env` file with your access token:

```bash
ACCESS_TOKEN=your_secret_token_here
```

Then run:

```bash
docker-compose up -d
```

### Multiple Containers

To run multiple viewers simultaneously, create a `docker-compose.yml` file:

```yaml
services:
  viewer1:
    image: feelingsurf/viewer:stable
    environment:
      - access_token=${ACCESS_TOKEN}
    restart: unless-stopped
    tmpfs:
      - /tmp
      - /dev/shm
    logging:
      driver: "json-file"
      options:
        max-size: "10m"
        max-file: "3"

  viewer2:
    image: feelingsurf/viewer:stable
    environment:
      - access_token=${ACCESS_TOKEN}
    restart: unless-stopped
    tmpfs:
      - /tmp
      - /dev/shm
    logging:
      driver: "json-file"
      options:
        max-size: "10m"
        max-file: "3"

  viewer3:
    image: feelingsurf/viewer:stable
    environment:
      - access_token=${ACCESS_TOKEN}
    restart: unless-stopped
    tmpfs:
      - /tmp
      - /dev/shm
    logging:
      driver: "json-file"
      options:
        max-size: "10m"
        max-file: "3"
```

Create a `.env` file with your access token:

```bash
ACCESS_TOKEN=your_secret_token_here
```

Then run:

```bash
docker-compose up -d
```

## Resource Recommendations

- **Memory:** 2GB per container
- **CPU:** 2 cores per container
- **tmpfs:** Mount `/tmp` and `/dev/shm` as tmpfs for better performance

## Health Check

The container includes a built-in health check on port 3000. Docker will automatically monitor the container health using this endpoint.
