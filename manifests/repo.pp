class r1soft::repo {
  if $r1soft::agent::repo_install {
    yumrepo { 'r1soft':
      descr    => 'r1soft',
      enabled  => bool2num($r1soft::agent::repo_enabled),
      gpgcheck => bool2num($r1soft::agent::repo_gpgcheck),
      baseurl  => $r1soft::agent::repo_baseurl,
    }
  }
}
