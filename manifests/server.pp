class r1soft::server (
  $repo_install               = $r1soft::params::repo_install,
  $cdp_server_package_version = $r1soft::params::cdp_server_package_version,
  $cdp_server_package_name    = $r1soft::params::cdp_server_package_name,

  $service_manage      = $r1soft::params::server_service_manage,
  $service_name        = $r1soft::params::server_service_name,
  $service_ensure      = $r1soft::params::server_service_ensure,
  $service_enable      = $r1soft::params::server_service_enable,
)
inherits r1soft::params {
  validate_bool($repo_install)
  validate_string($cdp_server_package_version)
  validate_string($cdp_server_package_name)

  validate_bool($service_manage)
  validate_string($service_name)
  validate_string($service_ensure)
  validate_bool($service_enable)

  if $repo_install {
    include r1soft::repo
    Class['r1soft::repo'] -> Package <| title == "$cdp_server_package_name" |>
  }


  anchor {'r1soft::server::begin':} ->
  class{'::r1soft::server::install':} ->
  class{'::r1soft::server::service':} ->
  anchor {'r1soft::server::end':}
}
