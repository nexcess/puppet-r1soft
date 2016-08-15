class r1soft::server::service {
  if $r1soft::server::service_manage {
    service { $r1soft::server::service_name:
      ensure => $r1soft::server::service_ensure,
      enable => $r1soft::server::service_enable,
    }
  }
}
