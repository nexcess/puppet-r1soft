class r1soft::agent::install {
  package { 'serverbackup-agent':
    ensure => $r1soft::agent::cdp_agent_version,
  }
}
