view: customer_peer {
  sql_table_name: dashboard_test.customer_peer ;;

  dimension: customer_id {
    type: number
    sql: ${TABLE}."customer_id" ;;
  }

  dimension: masked_peer_name {
    type: string
    sql: ${TABLE}."masked_peer_name" ;;
  }

  dimension: peer_id {
    type: number
    sql: ${TABLE}."peer_id" ;;
  }

  measure: count {
    type: count
    drill_fields: [masked_peer_name]
  }
}
