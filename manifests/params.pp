class r1soft::params {
  $repo_install               = true
  $repo_baseurl               = 'http://repo.r1soft.com/yum/stable/$basearch/'
  $repo_enabled               = '1'
  $repo_gpgcheck              = '0' # r1soft doesn't sign their packages
  $cdp_agent_version          = 'present'
  $cdp_agent_package          = 'serverbackup-agent'
  $cdp_agent_running          = 'running'
  $cdp_agent_enabled          = true
  $kernel_devel_install       = true
  $kernel_devel_package_names = ["kernel-devel","kernel-devel-${kernelrelease}"]
  $kernel_module_install      = true
  $kernel_module_name         = 'hcpdriver'
  $service_manage             = true
  $service_name               = 'cdp-agent'
}
