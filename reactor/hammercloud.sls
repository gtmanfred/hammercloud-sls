new_version:
  cmd.state.sls:
    - tgt: hammercloud.gtmanfred.com
    - arg:
      - git
    - kwarg:
        pillar:
          body: {{ data['body'] }}
