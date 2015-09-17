class r1soft::agent::kernel_module {
  if $r1soft::agent::kernel_module_install {
    exec { 'hcp-setup --get-module':
       refreshonly => true,
       notify      => Package['serverbackup-agent'],
       path        => '/usr/sbin:/sbin:/bin:/usr/sbin',
    }
  }
}
