class r1soft::repo {
  yumrepo { 'r1soft':
    ensure   => $r1soft::agent::repo_ensure,
    enabled  => $r1soft::agent::repo_enabled,
    gpgcheck => $r1soft::agent::repo_gpgcheck,
    gpgkey   => $r1soft::agent::repo_gpgkey,
    baseurl  => $r1soft::agent::repo_baseurl,
  }
}
