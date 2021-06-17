include: "/views/period_over_period.view"

view: dt_distilled_flows_actor {
  view_label: "Distilled Flows Actor Details"
  extends: [period_over_period]
  derived_table: {
    sql: SELECT
        {% if proxy_ip._in_query %}
         date(datetime) as date
        {% else %}
        date
        {% endif %}
        {% if actor._in_query %}
        ,actor_id
        {% endif %}
        {% if customer._in_query or actor.my_data_or_all_data._parameter_value == 'mydata' %}
        ,customer_id
        {% endif %}
        {% if autonomous_system._in_query %}
        ,proxy_asn
        {% endif %}
        {% if host._in_query %}
        ,host_id
        {% endif %}
        {% if proxy_ip._in_query %}
        ,proxy_ip
        {% else %}
        ,session_count
        {% endif %}
       FROM {% if proxy_ip._in_query %}
            dashboard.distilled_flows_v3
            {% elsif actor._in_query
                and autonomous_system._in_query
                and host._in_query
                and customer._in_query
                  or actor.my_data_or_all_data._parameter_value == 'mydata' %}
            dashboard_test.summary_distilled_flows_dcaph t
            {% elsif
                actor._in_query
                  and host._in_query
                  and customer._in_query
                    or actor.my_data_or_all_data._parameter_value == 'mydata' %}
            dashboard_test.summary_distilled_flows_dcah t
           {% elsif
                actor._in_query
                  and autonomous_system._in_query
                  and customer._in_query
                    or actor.my_data_or_all_data._parameter_value == 'mydata' %}
            dashboard_test.summary_distilled_flows_dcap t
            {% elsif
                actor._in_query
                  and autonomous_system._in_query
                  and host._in_query %}
            dashboard_test.summary_distilled_flows_dcaph t
           {% elsif
                autonomous_system._in_query
                  and host._in_query
                  and customer._in_query
                    or actor.my_data_or_all_data._parameter_value == 'mydata' %}
            dashboard_test.summary_distilled_flows_dcaph t
            {% elsif
                actor._in_query
                  and customer._in_query
                    or actor.my_data_or_all_data._parameter_value == 'mydata' %}
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
                and customer._in_query
                  or actor.my_data_or_all_data._parameter_value == 'mydata' %}
            dashboard_test.summary_distilled_flows_dcah t
            {% elsif
                autonomous_system._in_query
                  and customer._in_query
                    or actor.my_data_or_all_data._parameter_value == 'mydata' %}
            dashboard_test.summary_distilled_flows_dcap t
            {% elsif
                autonomous_system._in_query
                  and host._in_query %}
            dashboard_test.summary_distilled_flows_daph t
            {% elsif
                customer._in_query
                  or actor.my_data_or_all_data._parameter_value == 'mydata' %%}
            dashboard_test.summary_distilled_flows_dca t
            {% elsif
                actor._in_query %}
            dashboard_test.summary_distilled_flows_da t
            {% elsif
                autonomous_system._in_query %}
            dashboard_test.summary_distilled_flows_dap t
            {% elsif
               host._in_query %}
            dashboard_test.summary_distilled_flows_dah t
            {% else %}
            dashboard_test.summary_distilled_flows_da t
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

  dimension: proxy_ip {
    type: string
    sql: ${TABLE}."proxy_ip" ;;
    label: "Proxy IP"
  }

  measure: session_count {
    type: number
    sql: {% if proxy_ip._in_query %} count(1) {% else %} sum(${TABLE}.session_count) {% endif %} ;;
  }

}
