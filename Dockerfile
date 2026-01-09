FROM nvidia/cuda:12.8.0-devel-ubuntu24.04

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
    curl \
    python3.12 \
    python3.12-venv \
    python3-pip \
    && rm -rf /var/lib/apt/lists/* \
    && ln -sf /usr/bin/python3.12 /usr/bin/python

# PyTorch nightly CUDA 12.8 (from nightly index)
RUN pip install --pre torch torchvision torchaudio --index-url https://download.pytorch.org/whl/nightly/cu128

# Triton
RUN pip install triton

# SageAttention from source
RUN cd /tmp && \
    git clone https://github.com/thu-ml/SageAttention.git && \
    cd SageAttention && \
    pip install -e .

WORKDIR /workspace

# ComfyUI
RUN git clone https://github.com/comfyanonymous/ComfyUI.git && \
    cd ComfyUI && \
    pip install -r requirements.txt

# ComfyUI Manager
RUN cd /workspace/ComfyUI/custom_nodes && \
    git clone https://github.com/ltdrdata/ComfyUI-Manager.git

# ===== CUSTOM NODES =====

# Wan 2.2 Video Wrapper
RUN cd /workspace/ComfyUI/custom_nodes && \
    git clone https://github.com/kijai/ComfyUI-WanVideoWrapper.git && \
    pip install -r ComfyUI-WanVideoWrapper/requirements.txt || true

# Video Helper Suite
RUN cd /workspace/ComfyUI/custom_nodes && \
    git clone https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite.git && \
    pip install -r ComfyUI-VideoHelperSuite/requirements.txt || true

# Impact Pack
RUN cd /workspace/ComfyUI/custom_nodes && \
    git clone https://github.com/ltdrdata/ComfyUI-Impact-Pack.git && \
    pip install -r ComfyUI-Impact-Pack/requirements.txt || true

# KJNodes
RUN cd /workspace/ComfyUI/custom_nodes && \
    git clone https://github.com/kijai/ComfyUI-KJNodes.git && \
    pip install -r ComfyUI-KJNodes/requirements.txt || true

# Frame Interpolation
RUN cd /workspace/ComfyUI/custom_nodes && \
    git clone https://github.com/Fannovel16/ComfyUI-Frame-Interpolation.git && \
    pip install -r ComfyUI-Frame-Interpolation/requirements.txt || true

# Essentials
RUN cd /workspace/ComfyUI/custom_nodes && \
    git clone https://github.com/cubiq/ComfyUI_essentials.git && \
    pip install -r ComfyUI_essentials/requirements.txt || true

# rgthree
RUN cd /workspace/ComfyUI/custom_nodes && \
    git clone https://github.com/rgthree/rgthree-comfy.git

# WAS Node Suite
RUN cd /workspace/ComfyUI/custom_nodes && \
    git clone https://github.com/WASasquatch/was-node-suite-comfyui.git && \
    pip install -r was-node-suite-comfyui/requirements.txt || true

# Segment Anything 2
RUN cd /workspace/ComfyUI/custom_nodes && \
    git clone https://github.com/kijai/ComfyUI-segment-anything-2.git && \
    pip install -r ComfyUI-segment-anything-2/requirements.txt || true

# ControlNet Aux
RUN cd /workspace/ComfyUI/custom_nodes && \
    git clone https://github.com/Fannovel16/comfyui_controlnet_aux.git && \
    pip install -r comfyui_controlnet_aux/requirements.txt || true

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
