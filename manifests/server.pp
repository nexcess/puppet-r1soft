class r1soft::server (
  $repo_install    = $r1soft::params::repo_install,
  $package_version = $r1soft::params::server_package_version,
  $package_name    = $r1soft::params::server_package_name,
  $service_manage  = $r1soft::params::server_service_manage,
  $service_name    = $r1soft::params::server_service_name,
  $service_ensure  = $r1soft::params::server_service_ensure,
  $service_enable  = $r1soft::params::server_service_enable,
  $admin_user      = $r1soft::params::server_admin_user,
  $admin_pass      = $r1soft::params::server_admin_pass,
  $max_mem         = $r1soft::params::server_max_mem,
  $http_port       = $r1soft::params::server_http_port,
  $https_port      = $r1soft::params::server_https_port,
)
inherits r1soft::params {
  validate_bool($repo_install)
  validate_string($package_version)
  validate_string($package_name)
  validate_bool($service_manage)
  validate_string($service_name)
  validate_string($service_ensure)
  validate_bool($service_enable)
  validate_string($admin_user)
  validate_string($admin_pass)
  validate_string($max_mem)
  validate_integer($http_port)
  validate_integer($https_port)

  if $repo_install {
    include r1soft::repo
    Yumrepo['r1soft'] -> Package <| title == $package_name |>
  }


  anchor {'r1soft::server::begin':} ->
  class{'::r1soft::server::install':} ->
  class{'::r1soft::server::config':} ->
  class{'::r1soft::server::service':} ->
  anchor {'r1soft::server::end':}
}
