FROM hearmeman/comfyui-wan-template:v10

SHELL ["/bin/bash", "-c"]

# ===== ADDITIONAL CUSTOM NODES =====
# Add your own nodes here

# Example:
# RUN cd /workspace/ComfyUI/custom_nodes && \
#     git clone https://github.com/author/node-name.git && \
#     pip install -r node-name/requirements.txt || true

# JupyterLab (if not already installed)
RUN pip install jupyterlab || true

# Expose ports
EXPOSE 8188 8888

# Start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]
