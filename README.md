# jupyter-docker

Dockerized version of [JupyterLab](https://jupyterlab.readthedocs.io/en/stable/getting_started/overview.html).

## Getting Started

The JupyterLab service can be run in the background using
```
docker compose up -d
```

This will build the image if it is not always present on your machine.

### Connecting to a running JupyterLab instance

The easiest way to connect to a running JupyterLab instance is by running the bash script
```
./bin/get-running-nb-servers.sh
```
This displays the port and token information for any running JupyterLab services, which
can be pasted into a browser (or clicked) to run.

### Stopping a running JupyterLab instance

In order to gracefully stop a running JupyterLab instance, run the bash script
```
./bin/stop-running-nb-servers.sh
```
