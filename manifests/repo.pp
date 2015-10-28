class r1soft::repo {
  yumrepo { 'r1soft':
    descr    => 'r1soft',
    enabled  => bool2num($r1soft::agent::repo_enabled),
    gpgcheck => bool2num($r1soft::agent::repo_gpgcheck),
    baseurl  => $r1soft::agent::repo_baseurl,
  }
}
