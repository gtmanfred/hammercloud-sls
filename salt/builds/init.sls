docker:
  pkg.installed:
    - name: docker.io

/builds/archlinux/Dockerfile:
  file.managed:
    - makedirs: True
    - source: salt://builds/files/archlinux

/builds/archlinux/makepkg.conf:
  file.managed:
    - makedirs: True
    - source: salt://builds/files/makepkg.conf

/builds/deb/Dockerfile:
  file.managed:
    - makedirs: True
    - source: salt://builds/files/deb

/builds/rpm7/Dockerfile:
  file.managed:
    - makedirs: True
    - source: salt://builds/files/rpm7

/builds/rpm6/Dockerfile:
  file.managed:
    - makedirs: True
    - source: salt://builds/files/rpm6

/builds/deb/build:
  file.managed:
    - makedirs: True
    - source: salt://builds/files/builddeb

/builds/archlinux/build:
  file.managed:
    - makedirs: True
    - source: salt://builds/files/buildarchlinux

known_hosts:
  file.managed:
    - contents_pillar: known_hosts
    - names:
      - /builds/rpm7/known_hosts
      - /builds/rpm6/known_hosts
      - /builds/deb/known_hosts
      - /builds/archlinux/known_hosts

/builds/rpm7/build:
  file.managed:
    - makedirs: True
    - source: salt://builds/files/buildrpm7
 
/builds/rpm6/build:
  file.managed:
    - makedirs: True
    - source: salt://builds/files/buildrpm6

id_rsa:
  file.managed:
    - contents_pillar: ssh_key
    - names:
      - /builds/rpm7/id_rsa
      - /builds/rpm6/id_rsa
      - /builds/deb/id_rsa
      - /builds/archlinux/id_rsa

private.key:
  file.managed:
    - contents_pillar: gpg:private
    - names:
      - /builds/rpm6/private.key
      - /builds/rpm7/private.key
      - /builds/deb/private.key
      - /builds/archlinux/private.key

public.key:
  file.managed:
    - contents_pillar: gpg:public
    - names:
      - /builds/rpm6/public.key
      - /builds/rpm7/public.key
      - /builds/deb/public.key
      - /builds/archlinux/public.key

base_images:
  cmd.run:
    - names:
      - docker build -t mydeb /builds/deb
      - docker build -t myarchlinux /builds/archlinux
      - docker build -t myrpm7 /builds/rpm7
      - docker build -t myrpm6 /builds/rpm6
    - requires:
      - file: id_rsa
      - file: known_hosts
      - file: public.key
      - file: private.key
      - file: /builds/deb/Dockerfile
      - file: /build/rpm7/Dockerfile
      - file: /build/rpm6/Dockerfile
      - file: /builds/archlinux/Dockerfile
      - file: /builds/archlinux/makepkg.conf
      - file: /builds/deb/build
      - file: /builds/archlinux/build
      - file: /builds/rpm6/build
      - file: /builds/rpm7/build
      - pkg: docker.io
