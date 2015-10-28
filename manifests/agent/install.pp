class r1soft::agent::install {
  package { $r1soft::agent::cdp_agent_package_name:
    ensure => $r1soft::agent::cdp_agent_package_version,
  }
}
