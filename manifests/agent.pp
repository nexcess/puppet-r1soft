class r1soft::agent (
  $cdp_agent_install = $r1soft::params::cdp_agent_install,
  $cdp_agent_version = $r1soft::params::cdp_agent_version,
) inherits r1soft::params {

  class{'::r1soft::repo':}
  class{'::r1soft::agent::kernel_package':}
  class{'::r1soft::agent::install':}
  class{'::r1soft::agent::kernel_module':}
  class{'::r1soft::agent::service':}
} 
