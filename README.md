# jupyter-docker

Dockerized app with a jupyter-lab service.

## Getting Started

The `base` docker image associated with this project can be built from the root directory using

```
make image
```

The JupyterLab service can then be run in the background using
```
docker-compose up -d
```

## Connecting to a running JupyterLab instance

The easiest way to connect to a running JupyterLab instance is by running the bash script

```
bin/get-running-nb-servers.sh
```

This displays the port and token information for any running JupyterLab servicecs, which
can be pasted into a browser (or clicked) to run.
