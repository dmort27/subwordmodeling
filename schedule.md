{% comment %}
The following table creates the course schedule table. See [`config.md`](config.md) for info on how it's generated (or
just read the code :P).
{% endcomment %}

<table>
  <tr>
    <th>Date</th>
    <th>Day</th>
    <th>Lec #</th>
    <th>Topic</th>
    <th>Assignment</th>
    <!-- add additional column header labels here -->
    <!-- and add data rows similarly below -->
    <!--<th>Instructor</th>-->
  </tr>
{% for lec in site.data.schedule %}

{% if lec.Lec %}
  <tr class="lec">
  {% else %}
  <tr class="nolec">
  {% endif %}
    <td>{{ lec.Date }}</td>
    <td>{{ lec.Day }}</td>
    <td>{{ lec.Lec }}</td>
    <td>
      {% if lec.Lec %}
        {% if lec["Topic Slide Link"] %}
          <a href="lectures/{{ lec["Topic Tag"] }}.html">{{ lec.Topic }}</a>
        {% else %}
          {{ lec.Topic }}
        {% endif %}
      {% else %}
          {{ lec.Topic }}
      {% endif %}
    </td>
    <td>
        {% if lec.Assignment %}
            <a href="assignments/{{ lec["Assignment Tag"] }}.html">{{ lec.Assignment }}</a>
        {% endif %}
    </td>
    <!-- add additional columns from the schedule.csv by name like below -->
    <!--<td>{{ lec.Instructor }}</td>-->
  </tr>
{% endfor %}
</table>
