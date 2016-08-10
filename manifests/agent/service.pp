class r1soft::agent::service {
  if $r1soft::agent::service_manage {
    service { $r1soft::agent::service_name:
      ensure   => $r1soft::agent::service_ensure,
      enable   => $r1soft::agent::service_enable,
      provider => $r1soft::agent::service_provider,
    }
  }
}
