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
  }

  dimension: link_external_id_text {
    type: string
    sql: ${TABLE}."id_text";;
    link: {
      label: "Actor Research"
      url: "/dashboards-next/126?Actor+ID={{ value }}"
    }
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
