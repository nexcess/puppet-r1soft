class r1soft::repo (
  $repo_baseurl               = $r1soft::params::repo_baseurl,
  $repo_enabled               = $r1soft::params::repo_enabled,
  $repo_gpgcheck              = $r1soft::params::repo_gpgcheck,
)
inherits r1soft::params {
  validate_string($repo_baseurl)
  validate_bool($repo_enabled)
  validate_bool($repo_gpgcheck)

  yumrepo { 'r1soft':
    descr    => 'r1soft',
    enabled  => bool2num($repo_enabled),
    gpgcheck => bool2num($repo_gpgcheck),
    baseurl  => $repo_baseurl,
  }
}
