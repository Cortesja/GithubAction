# syntax=docker/dockerfile:1.7

# You can override this at build time:
#   docker buildx build --build-arg NETBOX_TAG=v4.3.0 ...
ARG NETBOX_TAG=v4.3-3.3.0
FROM netboxcommunity/netbox:${NETBOX_TAG}

# Install plugins into the same venv NetBox uses
USER root

# If any plugin pulls a source distribution, these build deps help on both amd64/arm64.
# If you want the smallest image and your builds succeed without these, you can remove this block.
RUN apt-get update && apt-get install -y --no-install-recommends \
      gcc \
      build-essential \
      libffi-dev \
      libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Install pinned plugin versions (no extra file needed)
RUN --mount=type=cache,target=/root/.cache/pip \
    /opt/netbox/venv/bin/pip install --no-cache-dir \
      netbox-acls==1.9.1 \
      netbox-floorplan-plugin==0.7.0 \
      netbox-qrcode==0.0.18 \
      netbox-reorder-rack==1.1.4 \
      netbox-secrets==2.3.4 \
      netbox-topology-views==4.3.0 \
      netboxlabs-netbox-branching==0.6.2 \
      slurpit_netbox==1.1.44 \
    && /opt/netbox/venv/bin/pip check

# Drop back to the default user in the base image
USER netbox
