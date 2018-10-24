class r1soft::agent (
  Boolean $repo_install              = $r1soft::params::repo_install,
  String $package_version            = $r1soft::params::agent_package_version,
  String $package_name               = $r1soft::params::agent_package_name,
  Boolean $kernel_devel_install      = $r1soft::params::kernel_devel_install,
  String $kernel_devel_package_names = $r1soft::params::kernel_devel_package_names,
  Boolean $service_manage            = $r1soft::params::agent_service_manage,
  String $service_name               = $r1soft::params::agent_service_name,
  String $service_ensure             = $r1soft::params::agent_service_ensure,
  Boolean $service_enable            = $r1soft::params::agent_service_enable,
  Hash $keys                         = $r1soft::params::keys,
  Boolean $keys_purge_unmanaged      = $r1soft::params::keys_purge_unmanaged,
  String $kmod_tool                  = $r1soft::params::agent_kmod_tool,
  Boolean $kmod_manage               = $r1soft::params::agent_kmod_manage,
)
inherits r1soft::params {

  if $repo_install {
    include r1soft::repo
    Yumrepo['r1soft'] -> Package <| title == $package_name |>
  }

  anchor {'r1soft::agent::begin':}
  -> class{'::r1soft::agent::kernel_package':}
  -> class{'::r1soft::agent::install':}
  -> class{'::r1soft::agent::service':}
  -> class{'::r1soft::agent::keys':}
  -> anchor {'r1soft::agent::end':}

  class{'::r1soft::agent::hcpdriver':}
}
