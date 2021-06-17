include: "/views/period_over_period.view"

view: dt_distilled_flows_actor {
  view_label: "Distilled Flows Actor Details"
  extends: [period_over_period]
  derived_table: {
    sql: SELECT
         date
        {% if actor._in_query %}
        ,actor_id
        {% endif %}
        {% if autonomous_system._in_query %}
        ,proxy_asn
        {% endif %}
        {% if host._in_query %}
        ,host_id
        {% endif %}
        {% if proxy_ip._in_query %}
        ,proxy_ip
        ,count(1)
        {% else %}
        ,session_count
        {% endif %}
       FROM {% if proxy_ip._in_query %}
            dashboard.distilled_flows_v3
            {% if actor._in_query
                and autonomous_system._in_query
                and host._in_query
                and customer._in_query or customer_peer._in_query %}
            dashboard_test.summary_distilled_flows_dcaph t
            {% elsif
                actor._in_query
                  and host._in_query
                  and customer._in_query or customer_peer._in_query %}
            dashboard_test.summary_distilled_flows_dcah t
           {% elsif
                actor._in_query
                  and autonomous_system._in_query
                  and customer._in_query or customer_peer._in_query %}
            dashboard_test.summary_distilled_flows_dcap t
            {% elsif
                actor._in_query
                  and autonomous_system._in_query
                  and host._in_query %}
            dashboard_test.summary_distilled_flows_dcaph t
           {% elsif
                autonomous_system._in_query
                  and host._in_query
                  and customer._in_query or customer_peer._in_query %}
            dashboard_test.summary_distilled_flows_dcph t
            {% elsif
                actor._in_query
                  and customer._in_query or customer_peer._in_query %}
            dashboard_test.summary_distilled_flows_dca t
            {% elsif
                actor._in_query
                and host._in_query %}
            dashboard_test.summary_distilled_flows_dah t
            {% elsif
                actor._in_query
                and autonomous_system._in_query %}
            dashboard_test.summary_distilled_flows_dap t
            {% elsif
                host._in_query
                and customer._in_query or customer_peer._in_query %}
            dashboard_test.summary_distilled_flows_dch t
            {% elsif
                autonomous_system._in_query
                  and customer._in_query or customer_peer._in_query %}
            dashboard_test.summary_distilled_flows_dcp t
            {% elsif
                autonomous_system._in_query
                  and host._in_query %}
            dashboard_test.summary_distilled_flows_dph t
            {% elsif
                customer._in_query or customer_peer._in_query %}
            dashboard_test.summary_distilled_flows_dc t
            {% elsif
                actor._in_query %}
            dashboard_test.summary_distilled_flows_da t
            {% elsif
                autonomous_system._in_query %}
            dashboard_test.summary_distilled_flows_dp t
            {% elsif
               host._in_query %}
            dashboard_test.summary_distilled_flows_dch t
            {% else %}
            dashboard_test.summary_distilled_flows_d t
            {% endif %}
       ;;
  }
}
