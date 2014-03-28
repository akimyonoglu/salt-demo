{% for user, values in pillar.get("users", {}).items() %}

{{ user }}:
  user.present:
    - createhome: True
    - passwd: {{ values.get("pwd", "*") }}
    - gid_from_name: True
    - require:
      - group: {{ user }}
  group.present:
    - system: False

{% if values.get("pub_key", "") %}
{{ user }}_ssh_key:
  ssh_auth.present:
    - name: {{ values.get("pub_key", "") }}
    - user: {{ user }}
    - require:
      - user: {{ user }}
{% endif %}

{% endfor %}
