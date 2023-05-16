{%- for item in site.data.schedule -%}
    {%- assign i = forloop.index0 -%}
    {%- if item["Topic Tag"] == page.slug -%}
        {%- break -%}
    {%- endif -%}
{%- endfor -%}

{%- assign curr = site.data.schedule[i] -%}

{%- if i == empty -%}
    Could not find flanking links for {{ page.slug }}
{%- else -%}
    {%- if i > 0 -%}
    Previous:
        {%- assign prev_i = i | minus: 1 -%}
        {%- assign prev = site.data.schedule[prev_i] -%}
        {%- assign page = site.lectures | where:"slug", prev["Topic Tag"] | first  -%}
<a href="{{ prev["Topic Tag"] }}.html">{{ prev["Topic"] }}</a>
&nbsp; | &nbsp;
    {%- endif -%}

    {%- assign next_i = i | plus: 1 -%}
    {%- assign next = site.data.schedule[next_i] -%}
    {%- if next  -%}
    Next: 
        {%- assign page = site.lectures | where:"slug", next["Topic Tag"] | first  -%}
<a href="{{ next["Topic Tag"] }}.html">{{ next["Topic"] }}</a>
    {%- endif -%}

{%- endif -%}
