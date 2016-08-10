class r1soft::params {
  $repo_install               = true
  $repo_baseurl               = 'http://repo.r1soft.com/yum/stable/$basearch/'
  $repo_enabled               = true

  # r1soft doesn't sign their packages
  $repo_gpgcheck              = false
  $cdp_agent_package_version  = 'present'
  $cdp_agent_package_name     = 'serverbackup-agent'
  $kernel_devel_install       = true

  # RHEL 5 has two special kernel packages, 'xen' which is only for x86_64 and
  # 'PAE' which is only i386. The kernelrelease output for these looks something
  # like '2.6.18-371.4.1.el5xen' so we have to use a regex to convert it to the
  # correct package name
  #
  # RHEL 6 did away with all the silliness and made PAE enabled by default and
  # made a PAE capable processor a requirement for RHEL 6. See
  # https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/6.0_Release_Notes/kernel.html#idp1066960
  #
  if ($::operatingsystem in ['CentOS', 'RedHat'] and versioncmp($::operatingsystemmajrelease, '5') == 0) {
    $kernel_devel_package_names = $::kernelrelease ? {
      /(PAE|xen)$/ => regsubst ($::kernelrelease, '(.*)(PAE|xen)', 'kernel-\2-devel-\1'),
      default      => "kernel-devel-${::kernelrelease}",
    }
  } else {
    $kernel_devel_package_names = "kernel-devel-${::kernelrelease}"
  }
  $service_manage             = true
  $service_name               = 'cdp-agent'
  $service_ensure             = 'running'
  $service_enable             = true
  $service_provider           = 'init'
  $keys                       = {}
  $keys_purge_unmanaged       = false
}
