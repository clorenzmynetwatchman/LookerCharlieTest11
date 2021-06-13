view: customer {
  sql_table_name: dashboard_test.customer ;;
  drill_fields: [id]

  filter: customer_filter {
    type: number
    description: "Filter only field used for Industry Peers dashboard"
    group_label: "Industry Peers Pivot"
  }

  parameter: my_stuff_all_stuff {
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

  dimension: industry {
    type: string
    sql: ${TABLE}."industry" ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}."name" ;;
  }

  dimension: customer_name_mask {
    type: string
    sql: CASE WHEN ${TABLE}.relationship = 'client' THEN CONCAT('Peer ', UPPER(LEFT(MD5(${TABLE}.name), 4))) END ;;
    description: "Customer names hashed for masking"
    hidden: yes
    group_label: "Industry Peers Pivot"
    can_filter: no
  }

  dimension: relationship {
    type: string
    sql: ${TABLE}."relationship" ;;
  }
  dimension: current_customer_industry {
    type: string
    label: "Customer"
    sql: CASE WHEN (${TABLE}.id = '{{_user_attributes['customer_id'] | floor }}')
              THEN ${TABLE}.name
              ELSE ${customer_name_mask} END ;;
    description: "PIVOT ME! Used in customer dashboards for industry peer comparison.  Yes, the label is confusing."
    group_label: "Industry Peers Pivot"
    can_filter: yes
  }

  dimension: current_industry {
    type: string
    sql: (SELECT industry FROM ${customer.SQL_TABLE_NAME} WHERE id = ${customer_filter} LIMIT 1);;
    description: "Selects industry when customer_name user attribute is set"
    hidden: yes
    group_label: "Industry Peers Pivot"
  }

  dimension: is_current_industry {
    type:  yesno
    sql:  ${TABLE}.industry = ${current_industry} ;;
    description: "Current insdustry flag. Allows for grouping of customers by industry"
    group_label: "Industry Peers Pivot"
  }

  dimension: current_customer {
    type: string
    sql: (SELECT ${TABLE}.name FROM ${customer.SQL_TABLE_NAME} WHERE ${TABLE}.id = ${customer_filter} LIMIT 1);;
    description: "Selects industry when customer_name user attribute is set"
    hidden: yes
  }

  dimension: is_current_customer {
    type:  yesno
    sql:  ${TABLE}.name = ${current_customer} ;;
    description: "Current customer flag"
    group_label: "Industry Peers Pivot"
  }

  dimension: my_stuff_filter_logic {
    type:  yesno
    sql:
    {% if my_stuff_all_stuff._parameter_value == 'mydata' %}
     ${TABLE}.name = ${current_customer}
    {% else %}
     1=1
    {% endif %};;
    hidden: yes
  }

  measure: count {
    type: count
  }
}
