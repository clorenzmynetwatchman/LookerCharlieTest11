view: customer {
  sql_table_name: dashboard_test.customer ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."id" ;;
  }

  dimension: industry {
    type: string
    sql: ${TABLE}."industry" ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}."name" ;;
  }

  dimension: relationship {
    type: string
    sql: ${TABLE}."relationship" ;;
  }

  measure: count {
    type: count
  }
}
