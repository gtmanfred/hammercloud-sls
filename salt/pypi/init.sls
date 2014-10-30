python-pip:
  pkg.installed

pypiserver:
  pip.installed:
    - name: pypiserver

  file.managed:
    - source: salt://pypi/files/pypi.service
    - name: /etc/systemd/system/pypi.service

  service.running:
    - name: pypi
    - enable: True
    - require:
      - file: /etc/systemd/system/pypi.service
      - pip: pypiserver
