class r1soft::agent::kernel_module {
  if $r1soft::agent::kernel_module_install {
    exec {'get and load r1soft kernel module':
      command     => '/usr/sbin/hcp-setup --get-module',
      refreshonly => true,
    }
  }
}
