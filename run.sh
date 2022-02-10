#!/bin/sh

echo "Starting rtl_433_mqtt_hass.py..."
python3 -u /rtl_433_mqtt_hass.py -d -u ${MQTT_USERNAME} -P ${MQTT_PASSWORD} -H ${MQTT_HOST} -D ${DISCOVERY_PREFIX} -R ${RTL_TOPIC}
