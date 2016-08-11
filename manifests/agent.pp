class r1soft::agent (
  $repo_install               = $r1soft::params::repo_install,
  $package_version            = $r1soft::params::agent_package_version,
  $package_name               = $r1soft::params::agent_package_name,
  $kernel_devel_install       = $r1soft::params::kernel_devel_install,
  $kernel_devel_package_names = $r1soft::params::kernel_devel_package_names,
  $service_manage             = $r1soft::params::agent_service_manage,
  $service_name               = $r1soft::params::agent_service_name,
  $service_ensure             = $r1soft::params::agent_service_ensure,
  $service_enable             = $r1soft::params::agent_service_enable,
  $service_provider           = $r1soft::params::agent_service_provider,
  $keys                       = $r1soft::params::keys,
  $keys_purge_unmanaged       = $r1soft::params::keys_purge_unmanaged,
)
inherits r1soft::params {
  validate_bool($repo_install)
  validate_string($package_version)
  validate_string($package_name)
  validate_bool($kernel_devel_install)
  validate_string($kernel_devel_package_names)
  validate_bool($service_manage)
  validate_string($service_name)
  validate_string($service_ensure)
  validate_bool($service_enable)
  validate_string($service_provider)
  validate_hash($keys)
  validate_bool($keys_purge_unmanaged)

  if $repo_install {
    include r1soft::repo
    Yumrepo['r1soft'] -> Package <| title == $package_name |>
  }

  anchor {'r1soft::agent::begin':} ->
  class{'::r1soft::agent::kernel_package':} ->
  class{'::r1soft::agent::install':} ->
  class{'::r1soft::agent::service':} ->
  class{'::r1soft::agent::keys':} ->
  anchor {'r1soft::agent::end':}
}
