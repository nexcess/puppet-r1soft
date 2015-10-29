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
  $keys                       = $r1soft::params::keys,
)
inherits r1soft::params {
  validate_string($repo_baseurl)
  validate_bool($repo_enabled)
  validate_bool($repo_gpgcheck)
  validate_string($cdp_agent_package_version)
  validate_string($cdp_agent_package_name)
  validate_bool($kernel_devel_install)
  validate_string($kernel_devel_package_names)
  validate_bool($kernel_module_install)
  validate_string($kernel_module_name)
  validate_bool($service_manage)
  validate_string($service_name)
  validate_string($service_ensure)
  validate_bool($service_enable)
  validate_hash($keys)

  anchor {'r1soft::agent::begin':} ->
  class{'::r1soft::repo':} ->
  class{'::r1soft::agent::kernel_package':} ->
  class{'::r1soft::agent::install':} ->
  class{'::r1soft::agent::kernel_module':} ->
  class{'::r1soft::agent::service':} ->
  class{'::r1soft::agent::keys':} ->
  anchor {'r1soft::agent::end':}
}
