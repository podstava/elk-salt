openjdk-8-jre:
  pkg:
    - installed

apt-transport-https:
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
  
elasticsearch_install:
  pkg.latest:
    - name: elasticsearch
    - refresh: True

elastic_conf:
  file.managed:
    - name: /etc/elasticsearch/elasticsearch.yml
    - source: salt://conf/elasticsearch.yml
    - template: jinja
    - defaults:
        host: {{ salt['dnsutil.A']('elk.metrics.d.enes.tech')[0] }}
 
logstash:
  pkg.latest:
    - name: logstash
    - refresh: True

logstash_conf:
  file.managed:
    - name: /etc/logstash/conf.d/elastic-output.conf
    - source: salt://conf/elastic-output.conf


kibana:
  pkg.latest:
    - name: kibana
    - refresh: True

kibana_conf:
  file.managed:
    - name: /etc/kibana/kibana.yml
    - source: salt://conf/kibana.yml
    - template: jinja
    - defaults:
        server_host: {{ salt['dnsutil.A']('elk.metrics.d.enes.tech')[0] }}
        elastic_url: {{ salt['dnsutil.A']('elk.metrics.d.enes.tech')[0] }} 

