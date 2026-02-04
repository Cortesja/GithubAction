ARG NETBOX_TAG=v4.3-3.3.0
FROM --platform=linux/arm64 docker.io/netboxcommunity/netbox:${NETBOX_TAG}

COPY plugin_requirements.txt /opt/netbox/plugin_requirements.txt

RUN --mount=type=cache,target=/root/.cache/uv \
    /usr/local/bin/uv pip install -r /opt/netbox/plugin_requirements.txt

COPY configuration/branching.py /etc/netbox/config/branching.py
COPY configuration/plugins.py /etc/netbox/config/plugins.py
RUN DEBUG="true" SECRET_KEY="dummydummydummydummydummydummydummydummydummydummy" \
    /opt/netbox/venv/bin/python /opt/netbox/netbox/manage.py col electstatic --no-input
