class r1soft::server (
  Boolean $repo_install   = $r1soft::params::repo_install,
  String $package_version = $r1soft::params::server_package_version,
  String $package_name    = $r1soft::params::server_package_name,
  Boolean $service_manage = $r1soft::params::server_service_manage,
  String $service_name    = $r1soft::params::server_service_name,
  String $service_ensure  = $r1soft::params::server_service_ensure,
  Boolean $service_enable = $r1soft::params::server_service_enable,
  String $admin_user      = $r1soft::params::server_admin_user,
  String $admin_pass      = $r1soft::params::server_admin_pass,
  String $max_mem         = $r1soft::params::server_max_mem,
  Integer $http_port      = $r1soft::params::server_http_port,
  Integer $https_port     = $r1soft::params::server_https_port,
)
inherits r1soft::params {

  if $repo_install {
    include r1soft::repo
    Yumrepo['r1soft'] -> Package <| title == $package_name |>
  }


  anchor {'r1soft::server::begin':}
  -> class{'::r1soft::server::install':}
  -> class{'::r1soft::server::config':}
  -> class{'::r1soft::server::service':}
  -> anchor {'r1soft::server::end':}
}
