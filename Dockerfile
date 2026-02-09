ARG NETBOX_TAG=v4.4-3.4.2
FROM --platform=linux/arm64 docker.io/netboxcommunity/netbox:${NETBOX_TAG}

USER root

COPY plugin_requirements.txt /opt/netbox/plugin_requirements.txt

RUN --mount=type=cache,target=/root/.cache/uv \
      /usr/local/bin/uv pip install -r /opt/netbox/plugin_requirements.txt

# These lines are only required if your plugin has its own static files.
COPY configuration/configuration.py /opt/netbox/netbox/netbox/configuration.py
RUN DEBUG="true" SECRET_KEY="dummydummydummydummydummydummydummydummydummydummy" \
    /opt/netbox/venv/bin/python /opt/netbox/netbox/manage.py collectstatic --no-input
