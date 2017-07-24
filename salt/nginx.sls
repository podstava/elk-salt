nginx-pack:
  pkg.installed:
    - names:
      - nginx

nginx:
  service:
    - running
    - reload: True
    - require:
      - pkg: nginx

