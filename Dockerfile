FROM python:3-alpine

# Copy files from root folder
COPY run.sh rtl_433_mqtt_hass.py /

RUN \
    pip install \
        --no-cache-dir \
        --prefer-binary \
        paho-mqtt \
    \
    && chmod a+x /run.sh

CMD [ "/run.sh" ]
