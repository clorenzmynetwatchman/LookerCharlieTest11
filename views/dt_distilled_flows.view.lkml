include: "/views/period_over_period.view"

view: dt_distilled_flows {
  view_label: "Distilled Flows"
  extends: [period_over_period]
  derived_table: {
    sql: SELECT
         id
         ,date
        {% if actor._in_query %}
        ,actor_id
        {% endif %}
        {% if customer._in_query or customer_peer._in_query or _explore._name contains "external" %}
        ,customer_id
        {% endif %}
        {% if autonomous_system._in_query %}
        ,proxy_asn
        {% endif %}
        {% if host._in_query %}
        ,host_id
        {% endif %}
        ,session_count
        ,lasttime
        ,firsttime
       FROM {% if actor._in_query
                and autonomous_system._in_query
                and host._in_query
                and customer._in_query or customer_peer._in_query or _explore._name contains "external" %}
            dashboard_test.summary_distilled_flows_dcaph t
            {% elsif
                actor._in_query
                  and host._in_query
                  and customer._in_query or customer_peer._in_query or _explore._name contains "external" %}
            dashboard_test.summary_distilled_flows_dcah t
           {% elsif
                actor._in_query
                  and autonomous_system._in_query
                  and customer._in_query or customer_peer._in_query or _explore._name contains "external" %}
            dashboard_test.summary_distilled_flows_dcap t
            {% elsif
                actor._in_query
                  and autonomous_system._in_query
                  and host._in_query %}
            dashboard_test.summary_distilled_flows_dcaph t
           {% elsif
                autonomous_system._in_query
                  and host._in_query
                  and customer._in_query or customer_peer._in_query or _explore._name contains "external" %}
            summary_distilled_flows_dcph t
            {% elsif
                actor._in_query
                  and customer._in_query or customer_peer._in_query or _explore._name contains "external" %}
            dashboard_test.summary_distilled_flows_dca t
            {% elsif
                actor._in_query
                and host._in_query %}
            dashboard_test.summary_distilled_flows_dah t
            {% elsif
                actor._in_query
                and autonomous_system._in_query %}
            dashboard_test.summary_distilled_flows_dap t
            {% elsif
                host._in_query
                and customer._in_query or customer_peer._in_query or _explore._name contains "external" %}
            dashboard_test.summary_distilled_flows_dch t
            {% elsif
                autonomous_system._in_query
                  and customer._in_query or customer_peer._in_query or _explore._name contains "external" %}
            dashboard_test.summary_distilled_flows_dcp t
            {% elsif
                autonomous_system._in_query
                  and host._in_query %}
            dashboard_test.summary_distilled_flows_dph t
            {% elsif
                customer._in_query or customer_peer._in_query or _explore._name contains "external" %}
            dashboard_test.summary_distilled_flows_dc t
            {% elsif
                actor._in_query %}
            dashboard_test.summary_distilled_flows_da t
            {% elsif
                autonomous_system._in_query %}
            dashboard_test.summary_distilled_flows_dp t
            {% elsif
               host._in_query %}
            dashboard_test.summary_distilled_flows_dch t
            {% else %}
            dashboard_test.summary_distilled_flows_d t
            {% endif %}
       ;;
  }

  dimension: id {
    type: number
    primary_key: yes
    hidden: yes
  }

  dimension: actor_id {
    type: number
    hidden: yes
    sql: ${TABLE}."actor_id" ;;
  }

  dimension: customer_id {
    type: number
    hidden: yes
    sql: ${TABLE}."customer_id" ;;
  }

  dimension_group: date {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."date" ;;
  }

  dimension: proxy_asn {
    type: number
    hidden: yes
    sql: ${TABLE}."proxy_asn" ;;
  }

  dimension: host_id {
    type: number
    hidden: yes
    sql: ${TABLE}."host_id" ;;
  }

  measure: session_count {
    type: sum
    }

  measure: lasttime {
    label: "Last Activity"
    type: date_time
    sql: MAX(dt_distilled_flows."lasttime") ;;
    html: {{ rendered_value | date: "%a %b %d %r %Y %Z" }} ;;
  }

  measure: firsttime {
    label: "First Activity"
    type: date_time
    sql: MIN(dt_distilled_flows."firsttime") ;;
    html: {{ rendered_value | date: "%a %b %d %r %Y %Z" }} ;;
  }

  measure: date_count {
    label: "Date Count"
    type: number
    sql: count(distinct ${TABLE}."date") ;;
  }
}
