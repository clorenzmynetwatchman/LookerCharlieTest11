view: summary_distilled_flows_tcapxh {
  sql_table_name: dashboard_test.summary_distilled_flows_tcapxh ;;

  dimension: actor_id {
    type: number
    sql: ${TABLE}."actor_id" ;;
  }

  dimension: timeframe_id {
    type: number
    sql: ${TABLE}."timeframe_id" ;;
  }

  dimension: crime1000 {
    type: yesno
    sql: ${TABLE}."crime1000" ;;
  }

  dimension: customer_id {
    type: number
    sql: ${TABLE}."customer_id" ;;
  }

  dimension: host_id {
    type: number
    sql: ${TABLE}."host_id" ;;
  }

  dimension: proxy_asn {
    type: number
    sql: ${TABLE}."proxy_asn" ;;
  }

  dimension: proxy_ip {
    type: string
    sql: ${TABLE}."proxy_ip" ;;
  }

  dimension: session_count {
    type: number
    sql: ${TABLE}."session_count" ;;
  }
}
