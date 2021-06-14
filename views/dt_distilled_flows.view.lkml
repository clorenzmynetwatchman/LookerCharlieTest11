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
        {% if customer._in_query %}
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
       FROM {% if customer._in_query + embed_customer_filter._is_filtered > 0
                and actor._in_query
                and autonomous_system._in_query
                and host._in_query %}
            dashboard_test.summary_distilled_flows_dcaph
            {% elsif
                customer._in_query
                  and actor._in_query
                  and host._in_query %}
            dashboard_test.summary_distilled_flows_dcah
           {% elsif
                customer._in_query
                  and actor._in_query
                  and autonomous_system._in_query %}
            dashboard_test.summary_distilled_flows_dcap
            {% elsif
                actor._in_query
                  and autonomous_system._in_query
                  and host._in_query %}
            dashboard_test.summary_distilled_flows_dcaph
           {% elsif
                customer._in_query
                  and autonomous_system._in_query
                  and host._in_query %}
            summary_distilled_flows_dcph
            {% elsif
                customer._in_query
                and actor._in_query %}
            dashboard_test.summary_distilled_flows_dca
            {% elsif
                actor._in_query
                and host._in_query %}
            dashboard_test.summary_distilled_flows_dah
            {% elsif
                actor._in_query
                and autonomous_system._in_query %}
            dashboard_test.summary_distilled_flows_dap
            {% elsif
                customer._in_query
                and host._in_query %}
            dashboard_test.summary_distilled_flows_dch
            {% elsif
                customer._in_query
                  and autonomous_system._in_query %}
            dashboard_test.summary_distilled_flows_dcp
            {% elsif
                autonomous_system._in_query
                  and host._in_query %}
            dashboard_test.summary_distilled_flows_dph
            {% elsif
                customer._in_query or embed_customer_filter._is_filtered %}
            dashboard_test.summary_distilled_flows_dc
            {% elsif
                actor._in_query %}
            dashboard_test.summary_distilled_flows_da
            {% elsif
                autonomous_system._in_query %}
            dashboard_test.summary_distilled_flows_dp
            {% elsif
               host._in_query %}
            dashboard_test.summary_distilled_flows_dch
            {% else %}
            dashboard_test.summary_distilled_flows_d
            {% endif %}
       ;;
  }

  filter: embed_customer_filter {
    type: number
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
    sql: count(${TABLE}."date") ;;
  }
}
