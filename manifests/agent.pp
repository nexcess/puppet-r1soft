class r1soft::agent (
  $repo_install  = $r1soft::params::repo_install,
  $repo_baseurl  = $r1soft::params::repo_baseurl,
  $repo_ensure   = $r1soft::params::repo_ensure,
  $repo_enabled  = $r1soft::params::repo_enabled,
  $repo_gpgcheck = $r1soft::params::repo_gpgcheck,
  $repo_gpgkey   = $r1soft::params::repo_gpgkey,
) inherits r1soft::params {

  class{'::r1soft::repo':}
  class{'::r1soft::agent::kernel_package':}
  class{'::r1soft::agent::install':}
  class{'::r1soft::agent::kernel_module':}
  class{'::r1soft::agent::service':}
} 
