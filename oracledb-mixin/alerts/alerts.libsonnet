{
  prometheusAlerts+:: {
    groups+: [
      {
        name: 'OracleDBAlerts',
        rules: [
          {
            alert: 'OracledbTablespaceReachingCapacity',
            expr: |||
              oracledb_tablespace_bytes / oracledb_tablespace_max_bytes * 100 > %(alertsTablespaceThreshold)s
            ||| % $._config,
            'for': '5m',
            labels: {
              severity: 'critical',
            },
            annotations: {
              summary: 'A tablespace is exceeding more than %(alertsTablespaceThreshold)s%% of its maximum allotted space.' % $._config,
              description:
                ('{{ printf "%%.2f" $value }}%% of bytes are being utilized by the tablespace {{$labels.tablespace}} on the instance {{$labels.instance}}, ' +
                 'which is above the threshold %(alertsTablespaceThreshold)s%%.') % $._config,
            },
          },
        ],
      },
    ],
  },
}
