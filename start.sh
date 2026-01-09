#!/bin/bash

echo "=========================================="
echo "Starting ComfyUI + JupyterLab"
echo "=========================================="

# If Volume has custom_nodes, use them (persistent)
if [ -d "/workspace/persistent_nodes" ]; then
    echo "Using persistent custom_nodes from Volume..."
    rm -rf /workspace/ComfyUI/custom_nodes
    ln -sf /workspace/persistent_nodes /workspace/ComfyUI/custom_nodes
else
    # First run - copy nodes to Volume for persistence
    echo "First run - setting up persistent nodes..."
    cp -r /workspace/ComfyUI/custom_nodes /workspace/persistent_nodes
    rm -rf /workspace/ComfyUI/custom_nodes
    ln -sf /workspace/persistent_nodes /workspace/ComfyUI/custom_nodes
fi

# Start JupyterLab in background
echo "Starting JupyterLab on port 8888..."
jupyter lab --ip=0.0.0.0 --port=8888 --allow-root --no-browser --ServerApp.token='' --ServerApp.password='' &

# Start ComfyUI
echo "Starting ComfyUI on port 8188..."
cd /workspace/ComfyUI
python main.py --listen 0.0.0.0 --port 8188 --enable-cors-header
