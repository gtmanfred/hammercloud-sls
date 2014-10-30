build_packages:
  cmd.state.sls:
    - tgt: hammercloud.gtmanfred.com
    - arg:
      - builds.buildpackages
    - kwarg:
        pillar:
          hcver: {{ data['data']['hcver'] }}
