# rtl_433 MQTT Auto Discovery Home Assistant Add-on

This Docker container helps Home Assistant discover and interpret sensor data that's published to MQTT by rtl_433. 

The container is a simple wrapper around the [rtl_433_mqtt_hass.py](https://github.com/merbanan/rtl_433/blob/a20cd1a62caa52dad97e4a99f8373b2fba3986d9/examples/rtl_433_mqtt_hass.py) script that's part of the excellent [rtl_433](https://github.com/merbanan/rtl_433) project. It is a fork of the excellent [RTL_433 Addons](https://github.com/pbkhrv/rtl_433-hass-addons) project, since that project is dependent on running Home Assistant OS. 

rtl_433 is a software package that receives wireless sensor data via [one of the supported SDR dongles](https://triq.org/rtl_433/HARDWARE.html), decodes and outputs it in a variety of formats including JSON and MQTT. The wireless sensors that rtl_433 understands transmit data mostly on 433.92 MHz, 868 MHz, 315 MHz, 345 MHz, and 915 MHz ISM bands.

## Getting Started

### Prerequisites

You need to have [rtl_433](https://github.com/merbanan/rtl_433) alreading running and populating MQTT. 

### Installation

To install and run:

 1. Clone this repo. 

 2. Edit `docker-compose.yml` to use the environment variables you need (as in the above step). These variables are:

 | Variable name | Required? |
 |---|---|
 | `MQTT_HOST` | Yes |
 | `MQTT_USERNAME` | Yes |
 | `MQTT_PASSWORD` | Yes |
 | `DISCOVERY_PREFIX` | Yes |
 | `RTL_TOPIC` | Yes |

 3. Run `docker-compose up -d`.

## What sensors/devices does this script support?

The script looks for specific bits of data in rtl_433's output to figure out what kind of sensor the data is coming from and to help Home Assistant handle it appropriately. For details about which devices are supported or how to add new devices, please see the [rtl_433](https://github.com/merbanan/rtl_433) project. 

More specifically, this script looks for the following keys in rtl_433's event data:
```
alarm
battery_ok
depth_cm
gust_speed_km_h
gust_speed_m_s
humidity
lux
moisture
noise
power_W
pressure_hPa
rain_in
rain_mm
rain_mm_h
rain_rate_in_h
rssi
snr
storm_dist
strike_count
strike_distance
tamper
temperature_1_C
temperature_2_C
temperature_C
temperature_F
uv
wind_avg_km_h
wind_avg_m_s
wind_avg_mi_h
wind_dir_deg
wind_max_m_s
wind_speed_km_h
wind_speed_m_s
```

In cases where none of the keys above appear, the script ignores the device that the event came from and doesn't notify Home Assistant about it.

## How it works

All this container does is run rtl_433_mqtt_hass.py. Quoting the script's description:

> Publish Home Assistant MQTT auto discovery topics for rtl_433 devices.

> rtl_433_mqtt_hass.py connects to MQTT and subscribes to the rtl_433 event stream that is published to MQTT by rtl_433. The script publishes additional MQTT topics that can be used by Home Assistant to automatically discover and minimally configure new devices.

> The configuration topics published by this script tell Home Assistant what MQTT topics to subscribe to in order to receive the data published as device topics by MQTT.

For more information, see [the original script](https://github.com/merbanan/rtl_433/blob/a20cd1a62caa52dad97e4a99f8373b2fba3986d9/examples/rtl_433_mqtt_hass.py) and [Home Assistant MQTT discovery documentation](https://www.home-assistant.io/docs/mqtt/discovery/).
