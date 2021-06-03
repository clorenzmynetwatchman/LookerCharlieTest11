include: "/views/period_over_period.view"

view: dt_distilled_flows {
  view_label: "Distilled Flows"
  extends: [period_over_period]
  derived_table: {
    sql: SELECT
         date
        {% if actor._in_query %}
        ,actor_id
        {% endif %}
        ,customer_id
        {% if autonomous_system._in_query %}
        ,proxy_asn
        {% endif %}
        {% if host._in_query %}
        ,host_id
        {% endif %}
        ,session_count
        ,lasttime
        ,firsttime
       FROM {% if customer._in_query
                and actor._in_query
                and autonomous_system._in_query
                and host._in_query %}
            if1
            {% elsif
                customer._in_query
                  and actor._in_query
                  and autonomous_system._in_query %}
            if2
            {% elsif
                customer._in_query
                  and actor._in_query
                  and host._in_query %}
            if3
            {% elsif
                customer._in_query
                and host._in_query %}
            dashboard_test.summary_distilled_flows_dch
            {% elsif
                customer._in_query
                  and autonomous_system._in_query %}
            dashboard_test.summary_distilled_flows_dcp
            {% else %}
            dashboard_test.summary_distilled_flows_dac
            {% endif %}
       ;;
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
    type:  max
    label: "Last Activity"
  }

  measure: firsttime{
    type:  min
    label: "First Activity"
  }
}
