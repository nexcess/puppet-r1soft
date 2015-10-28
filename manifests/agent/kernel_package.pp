class r1soft::agent::kernel_package {
  if $r1soft::agent::kernel_devel_install {
    package { $r1soft::agent::kernel_devel_package_names:
      ensure => 'present',
    }
  }
}
