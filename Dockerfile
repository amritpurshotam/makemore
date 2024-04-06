# full list of supported tags: https://gitlab.com/nvidia/container-images/cuda/blob/master/doc/supported-tags.md
# latest pytorch requirements: https://pytorch.org/get-started/locally/
FROM nvidia/cuda:12.1.1-cudnn8-devel-ubuntu22.04

# installs python 3.10.12 at time of writing
RUN apt-get update -y
RUN apt-get -y install python3 \ 
    && apt-get -y install python3-pip

WORKDIR /app/

COPY requirements.txt /app/

RUN python3 -m pip install --no-cache-dir --upgrade pip setuptools wheel \
    && pip install --no-cache-dir notebook ipywidgets \
    && pip install --no-cache-dir -r requirements.txt

EXPOSE 8888

ENTRYPOINT [ "jupyter", "notebook", "--ip=0.0.0.0", "--allow-root", "--no-browser", "--NotebookApp.allow_origin='*'"]