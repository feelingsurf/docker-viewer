# Official FeelingSurfViewer Docker image

[![Docker Stars](https://img.shields.io/docker/stars/feelingsurf/viewer.svg)](https://hub.docker.com/r/feelingsurf/viewer/)
[![Docker Pulls](https://img.shields.io/docker/pulls/feelingsurf/viewer.svg)](https://hub.docker.com/r/feelingsurf/viewer/)

The official FeelingSurf app in a container is [available on Docker Hub](https://hub.docker.com/r/feelingsurf/viewer/).

FeelingSurfViewer is also available as a regular Desktop app at [FeelingSurf](https://www.feelingsurf.fr/surf#app-download-modal).

# Usage

```
docker run -d -e access_token=<YOUR_SECRET_ACCESS_TOKEN> feelingsurf/viewer:stable
```

Disclaimer: never share your access token as it allows full access to your FeelingSurf account.
