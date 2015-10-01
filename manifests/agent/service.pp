class r1soft::agent::service(
  $cdp_agent_running = $r1soft::params::cdp_agent_running,
  $cdp_agent_enabled = $r1soft::params::cdp_agent_enabled,
  $service_name      = $r1soft::params::service_name
) inherits r1soft::params {
  if $service_manage {
    service { "$service_name":
      ensure => $cdp_agent_running,
      enable => $cdp_agent_enabled,
    }
  }
}
