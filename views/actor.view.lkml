view: actor {
  sql_table_name: dashboard_test.actor ;;

  parameter: my_data_or_all_data {
    type: unquoted
    allowed_value: {
      label: "My Data"
      value: "mydata"
    }
    allowed_value: {
      label: "All Data"
      value: "alldata"
    }
    default_value: "alldata"
  }

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."id" ;;
  }

  dimension: id_text {
    type: string
    sql: ${TABLE}."id_text";;
    html:
    {% if actor.actor_link_display_internal._in_query %}
    {% comment %} Flowrep (Internal) {% endcomment %}
    {{ value }} <a href="/dashboards-next/72?Actor+ID={{value}}" target="_blank" title="Research this actor"><img src="https://img.icons8.com/material-outlined/344/search-client.png" border=0 height=10 width=10></a>
    {% elsif actor.actor_link_display_external._in_query %}
    {% comment %} Flowrep (Customer) {% endcomment %}
    {{ value }} <a href="/dashboards-next/125?Actor+ID={{value}}" title="Research this actor"><img src="https://img.icons8.com/material-outlined/344/search-client.png" border=0 height=10 width=10></a>
    {% else %}
    {{linked_value}}
    {% endif %};;
  }

  dimension: last_country_alpha2 {
    type: string
    sql: ${TABLE}."last_country_alpha2" ;;
    map_layer_name: countries
  }

  dimension: last_country_alpha3 {
    type: string
    sql: ${TABLE}."last_country_alpha3" ;;
  }

  dimension: last_ip {
    type: string
    sql: ${TABLE}."last_ip" ;;
  }

  dimension: username {
    type: string
    sql: ${TABLE}."username" ;;
  }

  dimension: last_country {
    type: string
    sql: ${TABLE}."last_country" ;;
  }

  measure: count {
    type: count
  }
}
