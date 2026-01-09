# ComfyUI + Wan 2.1 + SageAttention for RunPod

Custom Docker image for running ComfyUI with Wan 2.1 video generation and SageAttention optimization.

## What's included

- ComfyUI (latest)
- ComfyUI Manager
- ComfyUI-WanVideoWrapper (Wan 2.1 support)
- SageAttention + Triton
- CUDA 12.8 + PyTorch 2.5.1

## RunPod Template Settings

| Setting | Value |
|---------|-------|
| Container image | `doctorasternous/comfyui-wan-sage:latest` |
| Container disk | 20 GB |
| Volume disk | 150 GB |
| HTTP ports | 8188 |

## GPU Requirements

- Wan 2.1 14B: 48GB+ VRAM (RTX 6000, A100, H100)
- SageAttention provides ~2x speedup
