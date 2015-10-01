class r1soft::agent::install(
  $cdp_agent_package = $r1soft::params::cdp_agent_package,
  $cdp_agent_version = $r1soft::params::cdp_agent_version
) inherits r1soft::params {
  if $r1soft::agent::cdp_agent_install {
    package { "$cdp_agent_package":
      ensure => $cdp_agent_version,
    }
  }
}
