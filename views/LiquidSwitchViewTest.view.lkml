view: liquidswitchviewtest {
   derived_table: {
     sql: SELECT
         date
        ,actor_id
        ,customer_id
        ,datasource_id
        {% if customer.id._in_query %}
        ,proxy_asn
        {% endif %}
        ,session_count
       FROM {% if customer.id._in_query %}
          dashboard_test.summary_distilled_flows_dacs
          {% else %}
          dashboard_test.summary_distilled_flows_dacsp
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

dimension: datasource_id {
  type: number
  hidden: yes
  sql: ${TABLE}."datasource_id" ;;
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

measure: session_count {
  type: sum
}
}
