FROM debian:12.6

ARG conda_env=runtime
ARG MINIFORGE_VER=24.9.0-0

COPY kneaddata_bmtagger_env.yml environment.yml

SHELL ["/bin/bash", "-c"]

RUN apt update && \
    apt upgrade -y && \
    apt install -y wget

RUN apt-get autoremove --yes && \
    apt-get clean --yes

# Install Miniforge
RUN echo "Installing Miniforge..." && \
    wget "https://github.com/conda-forge/miniforge/releases/download/$MINIFORGE_VER/Miniforge3-$MINIFORGE_VER-Linux-x86_64.sh"

RUN echo "Setting up Miniforge..." && \
    bash Miniforge3-$MINIFORGE_VER-Linux-x86_64.sh -b -p /miniforge && \
    rm Miniforge3-$MINIFORGE_VER-Linux-x86_64.sh

# Add Miniforge to path
ENV PATH "/miniforge/bin:${PATH}"

# Update conda
RUN echo "Updating conda..." && \
    conda update conda

RUN conda env create -f environment.yml && \
    conda clean -afy

ENV PATH "/miniforge/envs/${conda_env}/bin:$PATH"

ARG USER=appuser
ARG UID=1000
ARG GID=$UID

RUN groupadd --gid $GID $USER && \
    useradd --uid $UID --gid $GID --shell /bin/bash --create-home $USER

USER $USER

CMD ["/bin/bash"]
