#!/bin/bash

echo "=========================================="
echo "Starting ComfyUI with SageAttention"
echo "=========================================="

cd /workspace/ComfyUI

# Update ComfyUI and nodes if workspace is persistent
if [ -d "/workspace/ComfyUI/.git" ]; then
    echo "Updating ComfyUI..."
    git pull || true
fi

# Start ComfyUI
python main.py --listen 0.0.0.0 --port 8188 --enable-cors-header
