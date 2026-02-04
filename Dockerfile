ARG NETBOX_TAG=v4.3-3.3.0
FROM --platform=linux/arm64 docker.io/netboxcommunity/netbox:${NETBOX_TAG}

USER root

COPY plugin_requirements.txt /opt/netbox/plugin_requirements.txt

RUN --mount=type=cache,target=/root/.cache/uv \
    /usr/local/bin/uv pip install -r /opt/netbox/plugin_requirements.txt

COPY configuration/plugins.py /etc/netbox/config/plugins.py

USER 0
