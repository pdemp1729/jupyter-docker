FROM python:3.9-slim

WORKDIR /app

ARG APP_USER="bob"
ARG APP_UID="1000"

ENV HOME /home/$APP_USER
ENV JUPYTER_CONFIG_DIR /jupyter/.jupyter
ENV JUPYTER_DATA_DIR /jupyter/.local/share/jupyter
ENV JUPYTER_RUNTIME_DIR /jupyter/.local/share/jupyter/runtime
# Add /app to the python path. This ensures we can import modules correctly
ENV PYTHONPATH="$PYTHONPATH:/app"
# Set the locale
ENV LANG=C.UTF-8

# make sure the directories exist
RUN mkdir -p $HOME \
    && mkdir -p $JUPYTER_CONFIG_DIR \
    && mkdir -p $JUPYTER_DATA_DIR \
    && mkdir -p $JUPYTER_RUNTIME_DIR

# Upgrade pip
RUN pip3 install --upgrade pip

# Install Jupyter and Jupyterlab
RUN pip3 install --no-cache-dir \
        'ipywidgets==7.6.3' \
        'jupyter==1.0.0' \
        'jupyterlab==3.0.16' \
    && jupyter nbextension enable --py widgetsnbextension \
    && jupyter serverextension enable --py jupyterlab

# Install additional requirements for the package
RUN apt-get update \
    && apt-get install -y --no-install-recommends nodejs \
    && rm -r /var/lib/apt/lists/* \
    && apt-get autoremove -y

COPY requirements.txt /tmp/requirements.txt

RUN pip3 install --no-cache-dir --trusted-host pypi.python.org -r /tmp/requirements.txt

COPY notebooks /app/notebooks

# Create a non-root user and give them permissions to modify the data folder,
# relevant jupyter files, and the home folder.
# Ensure all jupyter config and data files are accessible by all users
RUN useradd -u $APP_UID $APP_USER \
    && chmod -R 777 /jupyter \
    && chown -R $APP_USER /app/notebooks \
    && chown -R $APP_USER /usr/local/share/jupyter/lab \
    && chown -R $APP_USER $HOME

# Switch to non-root user
USER $APP_USER
