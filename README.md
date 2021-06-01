# jupyter-docker

Dockerized version of [JupyterLab](https://jupyterlab.readthedocs.io/en/stable/getting_started/overview.html).

## Getting Started

The docker image associated with this project can be built from the root directory using
```
docker build -f Dockerfile -t jupyter-lab .
```

After specifying the notebook directory (`NB_DIRECTORY`) and optional notebook-specific
config (`NB_CONFIG`) in a .env file, the JupyterLab service can then be run in the background using
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

## Stopping a running JupyterLab instance

In order to gracefully stop a running JupyterLab instance, run the bash script
```
bin/stop-running-nb-servers.sh
```
