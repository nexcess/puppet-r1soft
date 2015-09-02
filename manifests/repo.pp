class r1soft::repo (
  $repo_install  = $r1soft::params::repo_install,
  $repo_baseurl  = $r1soft::params::repo_baseurl,
  $repo_enabled  = $r1soft::params::repo_enabled,
  $repo_gpgcheck = $r1soft::params::repo_gpgcheck,
  $repo_gpgkey   = $r1soft::params::repo_gpgkey,
) inherits r1soft::params {
  yumrepo { 'r1soft':
    enabled  => $repo_enabled,
    gpgcheck => $repo_gpgcheck,
    gpgkey   => $repo_gpgkey,
    baseurl  => $repo_baseurl,
  }
}
