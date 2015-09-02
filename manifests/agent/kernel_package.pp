class r1soft::agent::kernel_package(
  $cdp_agent_version          = $r1soft::params::cdp_agent_version,
  $kernel_devel_install       = $r1soft::params::kernel_devel_install,
  $kernel_devel_package_names = $r1soft::params::kernel_devel_package_names,
) inherits r1soft::params {
  if $kernel_devel_install {
    package { $kernel_devel_package_names:
      ensure => $cdp_agent_version,
    }
  }
}
