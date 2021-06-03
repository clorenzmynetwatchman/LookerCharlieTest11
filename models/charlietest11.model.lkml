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

explore: summary_distilled_flows_dacsp {
  label: "Distilled Flows"

  join: actor {
    type: left_outer
    sql_on: ${summary_distilled_flows_dacsp.actor_id} = ${actor.id} ;;
    relationship: many_to_one
  }

  join: customer {
    type: left_outer
    sql_on: ${summary_distilled_flows_dacsp.customer_id} = ${customer.id} ;;
    relationship: many_to_one
  }

  join: autonomous_system {
    type: left_outer
    sql_on: ${summary_distilled_flows_dacsp.proxy_asn} = ${autonomous_system.id} ;;
    relationship: many_to_one
  }

  join: flow_datasource {
    type: left_outer
    sql_on: ${summary_distilled_flows_dacsp.datasource_id} = ${flow_datasource.id}.id} ;;
    relationship: many_to_one
  }

  aggregate_table:  total_session_count {
    materialization: {
      datagroup_trigger: charlietest11_default_datagroup
      }
      query: {
        measures: [summary_distilled_flows_dacsp.session_count]
        }
      }

  aggregate_table:  session_count_by_d {
    materialization: {
      datagroup_trigger: charlietest11_default_datagroup
    }
    query: {
      dimensions: [summary_distilled_flows_dacsp.date_date]
      measures: [summary_distilled_flows_dacsp.session_count]
    }
  }
  }
