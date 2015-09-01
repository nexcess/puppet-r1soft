class r1soft::agent::install {
  if $r1soft::agent::cdp_agent_install {
    package { 'serverbackup-agent':
      ensure => $r1soft::agent::cdp_agent_version,
    }
  }
}
