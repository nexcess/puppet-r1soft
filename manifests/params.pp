class r1soft::params {
  $repo_baseurl               = 'http://repo.r1soft.com/yum/stable/$basearch/'
  $repo_enabled               = true

  # r1soft doesn't sign their packages
  $repo_gpgcheck              = false
  $cdp_agent_package_version  = 'present'
  $cdp_agent_package_name     = 'serverbackup-agent'
  $kernel_devel_install       = true
  $kernel_devel_package_names = "kernel-devel-${::kernelrelease}"
  $kernel_module_install      = true
  $kernel_module_name         = 'hcpdriver'
  $service_manage             = true
  $service_name               = 'cdp-agent'
  $service_ensure             = 'running'
  $service_enable             = true
}
