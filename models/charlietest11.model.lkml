connection: "phx-postgres"

# include all the views
include: "/views/**/*.view"

datagroup: charlietest11_default_datagroup {
  sql_trigger: SELECT current_date FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: charlietest11_default_datagroup

####################################################
# Base distilled flows summary explore.  Extended to distilled flows summary external
####################################################

explore: dt_distilled_flows {
  view_name: dt_distilled_flows
  label: "Distilled Flows Summary"

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

  join: customer_peer {
    type: inner
    sql_on: ${dt_distilled_flows.customer_id} = ${customer_peer.peer_id} ;;
    relationship: many_to_many
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
  dt_distilled_flows.date >= ${previous_start}
  {% else %}
  1 = 1
  {% endif %};;
}

####################################################
# Extended distilled flows summary explore for external customers
#   Also, secures customer by user attribute.
####################################################

explore: dt_distilled_flows_external {
  extends: [dt_distilled_flows]
  label: "Distilled Flows Summary External"

  sql_always_where:
  {% if customer_peer._in_query %}
  customer_peer.customer_id = '{{_user_attributes['customer_id'] | floor }}'
  {% else %}
  dt_distilled_flows.customer_id = '{{_user_attributes['customer_id'] | floor }}'
  {% endif %} ;;

}

####################################################
# Base distilled flows actor detail explore.
#    Extended to two other explores; actor detail with customer info (internal)
#      and actor detail without customer info (external)
####################################################

explore: dt_distilled_flows_actor {
  view_name: dt_distilled_flows_actor
  hidden: yes
  always_filter: {
    filters: [actor.id_text: ""]
  }

  join: actor {
    type: inner
    sql_on: ${dt_distilled_flows_actor.actor_id} = ${actor.id} ;;
    relationship: many_to_one
  }

  join: customer {
    type: inner
    sql_on: ${dt_distilled_flows_actor.customer_id} = ${customer.id} ;;
    relationship: many_to_one
  }

  join: autonomous_system {
    type: inner
    sql_on: ${dt_distilled_flows_actor.proxy_asn} = ${autonomous_system.id} ;;
    relationship: many_to_one
  }

  join: host {
    type: inner
    sql_on: ${dt_distilled_flows_actor.host_id} = ${host.id} ;;
    relationship: many_to_one
  }

  sql_always_where:
  {% if dt_distilled_flows_actor.date_filter._is_filtered %}
  dt_distilled_flows.date >= ${previous_start}
  {% else %}
  1 = 1
  {% endif %}
  and
  {% if actor.id_text._is_filtered %}
  1=1
  {% else %}
  1=0
  {% endif %};;
}

####################################################
# Extended distilled flows actor details w/ customer
#   for internal users
####################################################

explore: dt_distilled_flows_actor_wcust {
  extends: [dt_distilled_flows_actor]
  label: "Distilled Flows Actor Details"
  hidden: no

  join: customer {
    type: inner
    sql_on: ${dt_distilled_flows_actor.customer_id} = ${customer.id} ;;
    relationship: many_to_one
  }
}

####################################################
# Extended distilled flows actor details w/out customer
#   for external.  Also, secures customer by user attribute.
####################################################

explore: dt_distilled_flows_actor_details_external{
  extends: [dt_distilled_flows_actor]
  label: "Distilled Flows Actor Details External"
  hidden: no

  sql_always_where:
  {% if actor.my_actors_or_all_actors._parameter_value == 'myactors' %}
  dt_distilled_flows_actor.customer_id = '{{_user_attributes['customer_id'] | floor }}'
  {% else %}
  1=1
  {% endif %} ;;

  }
