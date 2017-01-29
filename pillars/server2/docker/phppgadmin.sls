docker:
  containers:
    phppgadmin:
      image: cloyne/phppgadmin
      network_mode:
        name: server2.cloyne.org
      environment:
        VIRTUAL_HOST: cloyne.org
        VIRTUAL_ALIAS: /phppgadmin/
        SET_REAL_IP_FROM: 172.19.0.0/16
        ADMINADDR:
          type: pillar
          key: mailer:root_alias
          join: ','
        REMOTES:
          type: pillar
          key: mailer:relay
      volumes:
        /srv/var/log/phppgadmin:
          bind: /var/log/nginx
          user: nobody
          group: nogroup
      dependencies:
        - pgsql
