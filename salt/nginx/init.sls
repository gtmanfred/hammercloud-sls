nginx:
  pkg.installed:
    - name: nginx-full

  file.absent:
    - names:
      - /etc/nginx/sites-enabled/default
      - /etc/nginx/sites-enabled/000-default

  service.running:
    - name: nginx
    - require:
      - file: pypi
      - file: repos
      - pkg: nginx-full

pypi:
  file.managed:
    - name: /etc/nginx/sites-enabled/pypi
    - source: salt://nginx/files/pypi

repos:
  file.managed:
    - name: /etc/nginx/sites-enabled/repos
    - source: salt://nginx/files/repos

