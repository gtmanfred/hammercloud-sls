hammercloud:
  git.latest:
    - name: git@github.com:<username>/hammercloud
    - rev: master
    - target: /srv/pypi/gitrepos/hammercloud
    - user: pypi

  file.symlink:
    - name: /srv/pypi/gitrepos/hammercloud/dist
    - target: /srv/pypi/packages
    - user: pypi
    - group: pypi

release:
  cmd.run:
    - name: python setup.py sdist
    - user: pypi
    - cwd: /srv/pypi/gitrepos/hammercloud
    - watch:
      - git: hammercloud
    - require:
      - file: hammercloud

salt/git/hammercloud/newrelease:
  event.send:
    - data:
        hcver: {{ salt['pillar.get']('body:ref') }}

docs:
  cmd.run:
    - name: pandoc -o /srv/pypi/site/index.html -f markdown -t html /srv/pypi/gitrepos/hammercloud/README.md
    - user: pypi
    - cwd: /srv/pypi/gitrepos/hammercloud
    - watch:
      - git: hammercloud
    - require:
      - file: hammercloud
