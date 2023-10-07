link _infos/homeassistant

# **visual studio code** on the client machine
  - https://www.youtube.com/watch?v=DV_OD4OPKno&list=PL4ed4sZb-R_8dJmakzfBywx1zL9HrFEOy&index=4
  - downolad **visual studio code**
  - add **Remote - SSH** extension
  - add **YAML** extension
  
# **Docker**
  - sudo apt-get purge modemmanager
  - sudo apt-get install docker-compose
  - sudo chmod 777 /opt
  - add **docker-compose.yaml** to opt
  - in opt folder **docker-compose up -d**

# **mosquitto**
  - https://www.youtube.com/watch?v=cZV2OOXLtEI&list=PL4ed4sZb-R_8dJmakzfBywx1zL9HrFEOy&index=7
  - make mosquitto.conf file
  - make container
  - on **mosquitto** container terminal sh
    - mosquitto_passwd -c /mosquitto/config/password.txt hass
    - exit
  - sudo chown rpi -R /opt
  - restart **mosquitto** contanier
  - on **homeassistant**
    - settings\devices\add integration\mqtt

# **zigbee2mqtt**
  - https://www.youtube.com/watch?v=sFSqgiOoPMs&list=RDCMUC67SMH0qLMJ4b4Guud0mKjw&index=1
  - ls -l /dev/serial/by-id    #list the used usb names
  - make zigbee2mqtt/data/configuration.yaml
  - make container
  - to homeassistant configuration.yaml

    ```
    Panel_iframe:
      zigbee2mqtt:
        title: "zigbee2mqtt"
        url: "http://192.168.1.200:8080"
        icon: mdi:zigbee
        require_admin: true
    ```
    - restart homeassistant


deepstack AI
  
