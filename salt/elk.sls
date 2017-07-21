openjdk-8-jre:
  pkg:
    - installed

apt-transport-http:
  pkg:
    - installed

elastic_repo:
  pkgrepo.managed:
    - humanname: elastic PPA
    - name: deb https://artifacts.elastic.co/packages/5.x/apt stable main
    - file: /etc/apt/sources.list.d/elastic-5.x.list
    - keyid: D88E42B4
    - keyserver: pgp.mit.edu
    - require_in:
      - pkg: elasticsearch
  
elasticsearch:
  pkg.latest:
    - require: elastic_repo
    - name: elasticsearch
    - refresh: True

  file.managed:
    - name: /etc/elasticsearch/elasticsearch.yml
    - source: salt://conf/elasticsearch
    - template: jinja

    - defaults:
        host: 'elastic_url'
 
logstash:
 pkg.latest:
    - require: elastic_repo
    - name: logstash
    - refresh: True

  file.managed:
    - name: /etc/logstash/conf.d/elastic-output.conf
    - source: salt://conf/elastic-output.conf
    - template: jinja

    - defaults:
        elasstic_url: elk.monitor.d.enes.tech


kibana:
  pkg.latest:
    - require: elastic_repo
    - name: kibana
    - refresh: True

  file.managed:
    - name: /etc/kibana/kibana.yml
    - source: salt://conf/kibana.yml
    - template: jinja

    - defaults:
        server_host: kibana_host
        elastic_url: elastic_url

