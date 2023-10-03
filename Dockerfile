ARG BASE_IMAGE
FROM $BASE_IMAGE

ENV APP_ROOT="/usr/app"
ENV PYTHONPATH="$PYTHONPATH:${APP_ROOT}"

ENV APP_USER="bob"
ENV APP_UID="1000"
ENV HOME /home/$APP_USER
ENV JUPYTER_CONFIG_DIR /jupyter/.jupyter
ENV JUPYTER_DATA_DIR /jupyter/.local/share/jupyter
ENV JUPYTER_RUNTIME_DIR /jupyter/.local/share/jupyter/runtime

WORKDIR ${APP_ROOT}

# make sure the directories exist
RUN mkdir -p $HOME \
    && mkdir -p $JUPYTER_CONFIG_DIR \
    && mkdir -p $JUPYTER_DATA_DIR \
    && mkdir -p $JUPYTER_RUNTIME_DIR

# Install Jupyter and Jupyterlab
RUN pip install --upgrade pip && \
    pip install --no-cache-dir \
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

COPY notebooks ${APP_ROOT}/notebooks

# Create a non-root user and give them permissions to modify the data folder,
# relevant jupyter files, and the home folder.
# Ensure all jupyter config and data files are accessible by all users
RUN useradd -u $APP_UID $APP_USER \
    && chmod -R 777 /jupyter \
    && chown -R $APP_USER ${APP_ROOT}/notebooks \
    && chown -R $APP_USER /usr/local/share/jupyter/lab \
    && chown -R $APP_USER $HOME

# Switch to non-root user
USER $APP_USER
