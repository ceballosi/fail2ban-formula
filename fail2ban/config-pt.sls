{% from "fail2ban/map.jinja" import fail2ban with context %}

include:
  - fail2ban

/etc/fail2ban/fail2ban.local:
  file.managed:
    - watch_in:
      - service: {{ fail2ban.service }}
    - contents: |
        # Autogenerated action from salt fail2ban formula
        {% for section, content in fail2ban.pt_config.iteritems() %}
        [{{ section }}]
        {% for key, value in content.iteritems() -%}
        {% set keyindent =  key|length + 3 + 8 %}
        {{ key }} = {{ value|string|indent(keyindent) }}
        {%- endfor %}
        {% endfor %}

/etc/fail2ban/jail.local:
  file.managed:
    - watch_in:
      - service: {{ fail2ban.service }}
    - contents: |
        # Autogenerated action from salt fail2ban formula
        {% for section, content in fail2ban.pt_jails.iteritems() %}
        [{{ section }}]
        {% for key, value in content.iteritems() -%}
        {% set keyindent =  key|length + 3 + 8 %}
        {{ key }} = {{ value|string|indent(keyindent) }}
        {%- endfor %}
        {% endfor %}

{% for name, config in fail2ban.pt_actions.iteritems() %}
/etc/fail2ban/action.d/{{ name }}.conf:
  file.managed:
    - watch_in:
      - service: {{ fail2ban.service }}
    - contents: |
        # Autogenerated action from salt fail2ban formula
        {% for section, content in config.iteritems() %}
        [{{ section }}]
        {% for key, value in content.iteritems() -%}
        {%- set keyindent =  key|length + 3 + 8 %}
        {{ key }} = {{ value|string|indent(keyindent) }}
        {%- endfor %}
        {% endfor %}
{% endfor%}

{% for name, config in fail2ban.pt_filters.iteritems() %}
/etc/fail2ban/filter.d/{{ name }}.conf:
  file.managed:
    - watch_in:
      - service: {{ fail2ban.service }}
    - contents: |
        # Autogenerated action from salt fail2ban formula
        {% for section, content in config.iteritems() %}
        [{{ section }}]
        {% for key, value in content.iteritems() -%}
        {% set keyindent =  key|length + 3 + 8 %}
        {{ key }} = {{ value|string|indent(keyindent) }}
        {%- endfor %}
        {% endfor %}
{% endfor%}

