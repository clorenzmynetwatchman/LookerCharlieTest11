- dashboard: flowrep_customer_postgres_summaries
  title: FlowRep Customer (Postgres Summaries)
  layout: newspaper
  preferred_viewer: dashboards-next
  elements:
  - title: Interval Change
    name: Interval Change
    model: charlietest11
    explore: dt_distilled_flows_external
    type: single_value
    fields: [dt_distilled_flows.session_count, dt_distilled_flows.timeframes]
    sorts: [dt_distilled_flows.timeframes]
    limit: 500
    dynamic_fields: [{table_calculation: interval_change, label: Interval Change,
        expression: "(index(${dt_distilled_flows.session_count},1)/index(${dt_distilled_flows.session_count},2))\
          \ - 1 ", value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
        _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: Sessions
    series_types: {}
    defaults_version: 1
    listen:
      My Flows: dt_distilled_flows.date_filter
      Embed Customer Filter: dt_distilled_flows.embed_customer_filter
    row: 2
    col: 0
    width: 4
    height: 3
  - title: Daily Average
    name: Daily Average
    model: charlietest11
    explore: dt_distilled_flows_external
    type: single_value
    fields: [dt_distilled_flows.timeframes, dt_distilled_flows.session_count, dt_distilled_flows.firsttime,
      dt_distilled_flows.lasttime]
    sorts: [dt_distilled_flows.timeframes]
    limit: 500
    dynamic_fields: [{table_calculation: daily_average, label: Daily Average, expression: "${dt_distilled_flows.session_count}/abs(diff_days(${dt_distilled_flows.lasttime},\
          \ ${dt_distilled_flows.firsttime}))", value_format: !!null '', value_format_name: decimal_0,
        _kind_hint: measure, _type_hint: number}, {table_calculation: da_interval_change,
        label: DA Interval Change, expression: "(index(${daily_average},1)/index(${daily_average},2))\
          \ - 1 ", value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
        _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: Daily Avg
    series_types: {}
    defaults_version: 1
    hidden_fields: [dt_distilled_flows.session_count, dt_distilled_flows.firsttime,
      dt_distilled_flows.lasttime]
    listen:
      My Flows: dt_distilled_flows.date_filter
      Embed Customer Filter: dt_distilled_flows.embed_customer_filter
    row: 2
    col: 4
    width: 4
    height: 3
  - title: Distinct Actors
    name: Distinct Actors
    model: charlietest11
    explore: dt_distilled_flows_external
    type: single_value
    fields: [dt_distilled_flows.timeframes, actor.count]
    filters: {}
    sorts: [dt_distilled_flows.timeframes]
    limit: 500
    dynamic_fields: [{table_calculation: interval_change, label: Interval Change,
        expression: "(index(${actor.count},1)/index(${actor.count},2)) - 1 ", value_format: !!null '',
        value_format_name: percent_1, _kind_hint: measure, _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: d754397b-2c05-4470-bbbb-05eb4c2b15cd
      palette_id: b0768e0d-03b8-4c12-9e30-9ada6affc357
    single_value_title: Distinct Actors
    series_types: {}
    defaults_version: 1
    hidden_fields: []
    listen:
      My Flows: dt_distilled_flows.date_filter
      Embed Customer Filter: dt_distilled_flows.embed_customer_filter
    row: 2
    col: 8
    width: 4
    height: 3
  - title: 30 Day Trend
    name: 30 Day Trend
    model: charlietest11
    explore: dt_distilled_flows_external
    type: single_value
    fields: [dt_distilled_flows.timeframes, dt_distilled_flows.session_count]
    filters:
      dt_distilled_flows.date_filter: 30 days ago for 30 days
    sorts: [dt_distilled_flows.session_count]
    limit: 500
    dynamic_fields: [{table_calculation: interval_change, label: Interval Change,
        expression: "(index(${dt_distilled_flows.session_count},1)/index(${dt_distilled_flows.session_count},2))\
          \ - 1 ", value_format: !!null '', value_format_name: percent_1, is_disabled: false,
        _kind_hint: measure, _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: 30 Day Trend
    series_types: {}
    defaults_version: 1
    hidden_fields: []
    listen:
      Embed Customer Filter: dt_distilled_flows.embed_customer_filter
    row: 2
    col: 12
    width: 4
    height: 3
  - title: 60 Day Trend
    name: 60 Day Trend
    model: charlietest11
    explore: dt_distilled_flows_external
    type: single_value
    fields: [dt_distilled_flows.timeframes, dt_distilled_flows.session_count]
    filters:
      dt_distilled_flows.date_filter: 60 days ago for 60 days
    sorts: [dt_distilled_flows.session_count]
    limit: 500
    dynamic_fields: [{table_calculation: interval_change, label: Interval Change,
        expression: "(index(${dt_distilled_flows.session_count},1)/index(${dt_distilled_flows.session_count},2))\
          \ - 1 ", value_format: !!null '', value_format_name: percent_1, is_disabled: false,
        _kind_hint: measure, _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: 60 Day Trend
    series_types: {}
    defaults_version: 1
    hidden_fields: []
    listen:
      Embed Customer Filter: dt_distilled_flows.embed_customer_filter
    row: 2
    col: 16
    width: 4
    height: 3
  - title: 90 Day Trend
    name: 90 Day Trend
    model: charlietest11
    explore: dt_distilled_flows_external
    type: single_value
    fields: [dt_distilled_flows.timeframes, dt_distilled_flows.session_count]
    filters:
      dt_distilled_flows.date_filter: 90 days ago for 90 days
    sorts: [dt_distilled_flows.session_count]
    limit: 500
    dynamic_fields: [{table_calculation: interval_change, label: Interval Change,
        expression: "(index(${dt_distilled_flows.session_count},1)/index(${dt_distilled_flows.session_count},2))\
          \ - 1 ", value_format: !!null '', value_format_name: percent_1, is_disabled: false,
        _kind_hint: measure, _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: 90 Day Trend
    series_types: {}
    defaults_version: 1
    hidden_fields: []
    listen:
      Embed Customer Filter: dt_distilled_flows.embed_customer_filter
    row: 2
    col: 20
    width: 4
    height: 3
  - title: Sessions
    name: Sessions
    model: charlietest11
    explore: dt_distilled_flows_external
    type: looker_line
    fields: [dt_distilled_flows.session_count, dt_distilled_flows.date_date, actor.count]
    fill_fields: [dt_distilled_flows.date_date]
    sorts: [dt_distilled_flows.date_date desc]
    limit: 500
    x_axis_gridlines: true
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: circle
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    y_axes: [{label: Sessions, orientation: left, series: [{axisId: dt_distilled_flows.session_count,
            id: dt_distilled_flows.session_count, name: Session Count}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}, {label: Distinct Actors, orientation: right, series: [{axisId: actor.count,
            id: actor.count, name: Actor}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    hidden_series: []
    series_types:
      actor.count: column
    series_colors:
      dt_distilled_flows.session_count: "#CE642D"
      actor.count: "#74A09F"
    series_labels: {}
    ordering: none
    show_null_labels: false
    show_dropoff: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    hidden_fields: []
    hidden_points_if_no: []
    listen:
      My Flows: dt_distilled_flows.date_filter
      Embed Customer Filter: dt_distilled_flows.embed_customer_filter
    row: 5
    col: 0
    width: 12
    height: 6
  - title: Host Names
    name: Host Names
    model: charlietest11
    explore: dt_distilled_flows_external
    type: looker_grid
    fields: [host.name, dt_distilled_flows.session_count]
    sorts: [dt_distilled_flows.session_count desc]
    limit: 500
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    listen:
      My Flows: dt_distilled_flows.date_filter
      Embed Customer Filter: dt_distilled_flows.embed_customer_filter
    row: 23
    col: 0
    width: 11
    height: 6
  - title: Known Bad Actors
    name: Known Bad Actors
    model: charlietest11
    explore: dt_distilled_flows_external
    type: looker_grid
    fields: [actor.id, actor.username, dt_distilled_flows.lasttime, dt_distilled_flows.session_count,
      actor.last_country]
    filters:
      actor.id: not -1
      actor.id_text: -"-1"
    sorts: [dt_distilled_flows.session_count desc]
    limit: 500
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_labels:
      actor.username: Actor Name
      actor.last_country_alpha3: Country
      dt_distilled_flows.session_count: Sessions
      actor.last_country: Country
    series_column_widths:
      dt_distilled_flows.lasttime: 229
    series_cell_visualizations:
      dt_distilled_flows.lasttime:
        is_active: true
      dt_distilled_flows.session_count:
        is_active: true
      actor.id:
        is_active: false
    series_text_format:
      actor.id: {}
    series_types: {}
    defaults_version: 1
    listen:
      My Flows: dt_distilled_flows.date_filter
      Embed Customer Filter: dt_distilled_flows.embed_customer_filter
    row: 11
    col: 0
    width: 24
    height: 6
  - title: Top 5 Known Countries
    name: Top 5 Known Countries
    model: charlietest11
    explore: dt_distilled_flows_external
    type: looker_pie
    fields: [dt_distilled_flows.session_count, actor.last_country]
    filters:
      actor.last_country: "-Unknown"
    sorts: [dt_distilled_flows.session_count desc]
    limit: 5
    value_labels: legend
    label_type: labPer
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    listen:
      My Flows: dt_distilled_flows.date_filter
      Embed Customer Filter: dt_distilled_flows.embed_customer_filter
    row: 5
    col: 12
    width: 12
    height: 6
  - title: Proxy ASNs
    name: Proxy ASNs
    model: charlietest11
    explore: dt_distilled_flows_external
    type: looker_grid
    fields: [autonomous_system.name, dt_distilled_flows.session_count]
    sorts: [dt_distilled_flows.session_count desc]
    limit: 500
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_column_widths:
      autonomous_system.name: 431
    series_cell_visualizations:
      dt_distilled_flows.session_count:
        is_active: true
    series_types: {}
    defaults_version: 1
    listen:
      My Flows: dt_distilled_flows.date_filter
      Embed Customer Filter: dt_distilled_flows.embed_customer_filter
    row: 23
    col: 11
    width: 13
    height: 6
  - title: Untitled
    name: Untitled
    model: charlietest11
    explore: dt_distilled_flows_external
    type: single_value
    fields: [customer.name]
    sorts: [customer.name]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#CE642D"
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    defaults_version: 1
    series_types: {}
    listen:
      My Flows: dt_distilled_flows.date_filter
      Embed Customer Filter: dt_distilled_flows.embed_customer_filter
    row: 0
    col: 0
    width: 24
    height: 2
  - title: Industry Peers
    name: Industry Peers
    model: charlietest11
    explore: dt_distilled_flows_external
    type: looker_line
    fields: [dt_distilled_flows.date_date, dt_distilled_flows.session_count, customer_peer.masked_peer_name]
    pivots: [customer_peer.masked_peer_name]
    fill_fields: [dt_distilled_flows.date_date]
    sorts: [customer_peer.masked_peer_name desc, dt_distilled_flows.date_date desc]
    limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    listen:
      My Flows: dt_distilled_flows.date_filter
      Embed Customer Filter: dt_distilled_flows.embed_customer_filter
    row: 17
    col: 0
    width: 24
    height: 6
  filters:
  - name: My Flows
    title: My Flows
    type: field_filter
    default_value: 30 day ago for 30 day
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
      options: []
    model: charlietest11
    explore: dt_distilled_flows_external
    listens_to_filters: []
    field: dt_distilled_flows.date_filter
  - name: Embed Customer Filter
    title: Embed Customer Filter
    type: field_filter
    default_value: '965'
    allow_multiple_values: true
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
      options:
      - '1'
      - '2'
      - '3'
    model: charlietest11
    explore: dt_distilled_flows_external
    listens_to_filters: []
    field: dt_distilled_flows.embed_customer_filter