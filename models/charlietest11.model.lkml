connection: "phx-postgres"

# include all the views
include: "/views/**/*.view"

datagroup: charlietest11_default_datagroup {
  sql_trigger: SELECT current_date FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: charlietest11_default_datagroup

explore: actor {}

explore: autonomous_system {}

explore: customer {}

explore: flow_datasource {}

explore: liquidswitchviewtest {
  label: "Distilled Flows"

  join: actor {
    type: inner
    sql_on: ${liquidswitchviewtest.actor_id} = ${actor.id} ;;
    relationship: many_to_one
  }

  join: customer {
    type: inner
    sql_on: ${liquidswitchviewtest.customer_id} = ${customer.id} ;;
    relationship: many_to_one
  }

  join: autonomous_system {
    type: inner
    sql_on: ${liquidswitchviewtest.proxy_asn} = ${autonomous_system.id} ;;
    relationship: many_to_one
  }

  join: flow_datasource {
    type: inner
    sql_on: ${liquidswitchviewtest.datasource_id} = ${flow_datasource.id}.id} ;;
    relationship: many_to_one
  }

  sql_always_where:
  {% if liquidswitchviewtest.date_filter._is_filtered %}
  liquidswitchviewtest.date >= ${previous_start}
  {% else %}
  1 = 1
  {% endif %};;

}
