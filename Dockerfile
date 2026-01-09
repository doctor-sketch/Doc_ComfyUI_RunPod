FROM nvidia/cuda:12.8.0-devel-ubuntu22.04

SHELL ["/bin/bash", "-c"]

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1

# System dependencies
RUN apt-get update && apt-get install -y \
    git \
    ffmpeg \
    libgl1 \
    libglib2.0-0 \
    wget \
    python3.11 \
    python3.11-venv \
    python3-pip \
    && rm -rf /var/lib/apt/lists/* \
    && ln -sf /usr/bin/python3.11 /usr/bin/python

# PyTorch nightly with CUDA 12.8
RUN pip install --pre torch torchvision torchaudio --index-url https://download.pytorch.org/whl/nightly/cu128

WORKDIR /workspace

# ComfyUI
RUN git clone https://github.com/comfyanonymous/ComfyUI.git && \
    cd ComfyUI && \
    pip install -r requirements.txt

# ComfyUI Manager
RUN cd /workspace/ComfyUI/custom_nodes && \
    git clone https://github.com/ltdrdata/ComfyUI-Manager.git

# Wan 2.1 Video Wrapper
RUN cd /workspace/ComfyUI/custom_nodes && \
    git clone https://github.com/kijai/ComfyUI-WanVideoWrapper.git && \
    cd ComfyUI-WanVideoWrapper && \
    pip install -r requirements.txt

# SageAttention + Triton
RUN pip install triton>=3.0.0 && \
    pip install sageattention

# Video processing
RUN pip install imageio[ffmpeg] imageio-ffmpeg

# JupyterLab
RUN pip install jupyterlab

# Expose ports
EXPOSE 8188 8888

# Start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]
