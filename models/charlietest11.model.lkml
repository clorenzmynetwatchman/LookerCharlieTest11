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

explore: dt_distilled_flows {
  label: "Distilled Flows"

  join: actor {
    type: inner
    sql_on: ${dt_distilled_flows.actor_id} = ${actor.id} ;;
    relationship: many_to_one
  }

  join: customer {
    type: inner
    sql_on: ${dt_distilled_flows.customer_id} = ${customer.id} ;;
    relationship: many_to_one
  }

  join: autonomous_system {
    type: inner
    sql_on: ${dt_distilled_flows.proxy_asn} = ${autonomous_system.id} ;;
    relationship: many_to_one
  }

  join: host {
    type: inner
    sql_on: ${dt_distilled_flows.host_id} = ${host.id} ;;
    relationship: many_to_one
  }


  sql_always_where:
  {% if dt_distilled_flows.date_filter._is_filtered %}
  liquidswitchviewtest.date >= ${previous_start}
  {% else %}
  1 = 1
  {% endif %};;

}