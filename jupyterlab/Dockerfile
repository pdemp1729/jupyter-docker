FROM python:3.7-slim

WORKDIR /app

COPY . /app

ARG NB_USER="bob"
ARG NB_UID="1000"
ARG NB_GID="100"

ENV JUPYTER_CONFIG_DIR /jupyter/.jupyter
ENV JUPYTER_DATA_DIR /jupyter/.local/share/jupyter
ENV JUPYTER_RUNTIME_DIR /jupyter/.local/share/jupyter/runtime

# make sure the directories exist
RUN mkdir -p $JUPYTER_CONFIG_DIR
RUN mkdir -p $JUPYTER_DATA_DIR
RUN mkdir -p $JUPYTER_RUNTIME_DIR

# Install required packages
RUN apt-get update && apt-get install -y build-essential python3-dev

# Install Jupyter
RUN pip3 install jupyter
RUN pip3 install ipywidgets
RUN jupyter nbextension enable --py widgetsnbextension

# Install JupyterLab
RUN pip3 install jupyterlab && jupyter serverextension enable --py jupyterlab

# Set the locale
ENV LANG=C.UTF-8

# Add a script that we will use to correct permissions after running certain commands
ADD fix-permissions /usr/local/bin/fix-permissions
RUN chmod +x /usr/local/bin/fix-permissions

RUN chmod -R 777 /jupyter

# Expose Jupyter port & cmd
EXPOSE 8888

RUN mkdir /home/$NB_USER && \
    fix-permissions /home/$NB_USER

RUN useradd -u $NB_UID $NB_USER && \
    chown -R $NB_USER /app/data && \
    chown -R $NB_USER /usr/local/share/jupyter/lab

USER $NB_USER
