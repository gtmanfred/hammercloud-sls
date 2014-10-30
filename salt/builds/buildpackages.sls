buildpackages:
  cmd.run:
    - names:
      - docker run -v "/var/www/html/archlinux:/var/www/html/archlinux" myarchlinux /build-package {{ pillar['hcver'] }}
      - docker run -v "/var/www/html/debian:/var/www/html/debian" mydeb /build-package {{ pillar['hcver'] }}
      - docker run -v "/var/www/html/rpm:/var/www/html/rpm" myrpm7 /build-package {{ pillar['hcver'] }}
      - docker run -v "/var/www/html/rpm:/var/www/html/rpm" myrpm6 /build-package {{ pillar['hcver'] }}
