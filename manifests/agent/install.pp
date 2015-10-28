class r1soft::agent::install {
  package { $r1soft::agent::cdp_agent_package:
    ensure => $r1soft::agent::cdp_agent_version,
  }
}
