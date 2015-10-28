class r1soft::agent (
  $repo_baseurl               = $r1soft::params::repo_baseurl,
  $repo_enabled               = $r1soft::params::repo_enabled,
  $repo_gpgcheck              = $r1soft::params::repo_gpgcheck,
  $cdp_agent_package_version  = $r1soft::params::cdp_agent_package_version,
  $cdp_agent_package_name     = $r1soft::params::cdp_agent_package_name,
  $kernel_devel_install       = $r1soft::params::kernel_devel_install,
  $kernel_devel_package_names = $r1soft::params::kernel_devel_package_names,
  $kernel_module_install      = $r1soft::params::kernel_module_install,
  $kernel_module_name         = $r1soft::params::kernel_module_name,
  $service_manage             = $r1soft::params::service_manage,
  $service_name               = $r1soft::params::service_name,
  $service_ensure             = $r1soft::params::service_ensure,
  $service_enable             = $r1soft::params::service_enable,
  ) inherits r1soft::params {

  class{'::r1soft::repo':} ->
  class{'::r1soft::agent::kernel_package':} ->
  class{'::r1soft::agent::install':} ->
  class{'::r1soft::agent::config':} ->
  class{'::r1soft::agent::kernel_module':} ->
  class{'::r1soft::agent::service':}
}
