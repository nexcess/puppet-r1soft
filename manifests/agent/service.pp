class r1soft::agent::service{
  if $r1soft::agent::service_manage {
    service { $r1soft::agent::service_name:
      ensure => $r1soft::agent::cdp_agent_running,
      enable => $r1soft::agent::cdp_agent_enabled,
    }
  }
}
