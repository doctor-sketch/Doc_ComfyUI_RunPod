#!/bin/bash

echo "=========================================="
echo "Starting ComfyUI + JupyterLab"
echo "=========================================="

# Start JupyterLab in background
echo "Starting JupyterLab on port 8888..."
jupyter lab --ip=0.0.0.0 --port=8888 --allow-root --no-browser --NotebookApp.token='' --NotebookApp.password='' &

# Start ComfyUI
echo "Starting ComfyUI on port 8188..."
cd /workspace/ComfyUI
python main.py --listen 0.0.0.0 --port 8188 --enable-cors-header
