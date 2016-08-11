class r1soft::repo (
  $baseurl  = $r1soft::params::repo_baseurl,
  $enabled  = $r1soft::params::repo_enabled,
  $gpgcheck = $r1soft::params::repo_gpgcheck,
)
inherits r1soft::params {
  validate_string($baseurl)
  validate_bool($enabled)
  validate_bool($gpgcheck)

  yumrepo { 'r1soft':
    descr    => 'r1soft',
    enabled  => bool2num($enabled),
    gpgcheck => bool2num($gpgcheck),
    baseurl  => $baseurl,
  }
}
