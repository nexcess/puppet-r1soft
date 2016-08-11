class r1soft::server::install {
  package { $r1soft::server::cdp_server_package_name :
    ensure => $r1soft::server::cdp_server_package_version,
  }
}
