view: summary_distilled_flows_dacsp {
  sql_table_name: dashboard_test.summary_distilled_flows_dacsp ;;
  view_label: "Distilled Flows"

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
