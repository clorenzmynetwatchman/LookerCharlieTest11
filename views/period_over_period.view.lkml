view: period_over_period {

  filter: date_filter {
    type: date
    #sql: ${timeframes} IS NOT NULL ;;  # This seems to work better filtered in the dashboard tile.
    description: "Use this date filter in combination with the timeframes dimension for period over period analysis."
    group_label: "Period over Period Comparison"
  }

  dimension: filter_start {
    type: date_raw
    sql: {% date_start date_filter %} /* Date Filter Start */;;
    description: "Filter start date"
    hidden: yes
  }

  dimension: filter_end {
    type: date_raw
    #sql: {% date_end date_filter %} - '1 day'::INTERVAL /* Date Filter End */;;
    sql: CASE WHEN {% date_end date_filter %} IS NULL
              THEN CURRENT_DATE - '1 day'::INTERVAL
              ELSE {% date_end date_filter %}::DATE - '1 day'::INTERVAL
         END ;;
    description: "Filter end date"

    hidden: yes
  }

  dimension: interval {
    type: string
    sql: ${filter_end} - ${filter_start} ;;
    description: "Number days between start date and end date"
    group_label: "Period over Period Comparison"
  }

  dimension: previous_end {
    type: date_raw
    sql: ${filter_start} - '1 day'::INTERVAL /* Previous End Date */;;
    description: "The end date of the previous period"
    hidden: yes
  }


  dimension: previous_start {
    type: date_raw
    sql: ${filter_start} - ${interval} - '1 day'::INTERVAL /* Previous Start Date */;;
    description: "The start date of the previous period"
    hidden: yes
  }

  dimension: timeframes {
    type: string
    sql:
      {% if date_filter._is_filtered %}
        CASE
            WHEN datetime >= ${filter_start} AND datetime <= ${filter_end}
              THEN 'Current Period'
            WHEN datetime >= ${previous_start} AND datetime <= ${previous_end}
              THEN 'Previous Period'
        END
      {% else %}
        NULL
      {% endif %} ;;
    description: "Use this field in combination with the date filter field for period over period analysis."
    group_label: "Period over Period Comparison"
  }
}
