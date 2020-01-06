class r1soft::agent::service {
  if $r1soft::agent::service_manage {
    if $facts['system_uptime']['seconds'] >= $r1soft::agent::delay_factor {
      service { $r1soft::agent::service_name:
        ensure => $r1soft::agent::service_ensure,
        enable => $r1soft::agent::service_enable,
      }
    }
  }
}
