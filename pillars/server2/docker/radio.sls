docker:
  containers:
    radio_mongodb:
      image: tozd/meteor-mongodb
      tag: 2.6
      network_mode:
        name: server2.cloyne.org
      volumes:
        /srv/radio/mongodb/data:
          bind: /var/lib/mongodb
        /srv/radio/mongodb/log:
          bind: /var/log/mongodb
        /srv/radio/run.config:
          bind: /etc/service/mongod/run.config
          type: file
    radio:
      image: mitar/radio-app
      network_mode:
        name: server2.cloyne.org
      environment:
        VIRTUAL_HOST: radio.cloyne.net
        VIRTUAL_URL: /
        ROOT_URL: http://radio.cloyne.net
        MAIL_URL: smtp://mail.cloyne.net
      volumes:
        /srv/radio/run.config:
          bind: /etc/service/meteor/run.config
          type: file
        /srv/radio/meteor/log:
          bind: /var/log/meteor
      dependencies:
        - radio_mongodb
