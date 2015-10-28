class r1soft::repo {
  yumrepo { 'r1soft':
    descr    => 'r1soft',
    enabled  => $r1soft::agent::repo_enabled,
    gpgcheck => $r1soft::agent::repo_gpgcheck,
    baseurl  => $r1soft::agent::repo_baseurl,
  }
}
