class r1soft::params {
  $repo_install      = true
  $repo_baseurl      = 'http://repo.r1soft.com/yum/stable/x86_64/'
  $repo_ensure       = 'present'
  $repo_enabled      = '1'
  $repo_gpgcheck     = '1'
  $repo_gpgkey       = 'https://www.ksplice.com/yum/RPM-GPG-KEY-ksplice'
  $cdp_agent_install = true
  $cdp_agent_version = 'present'
}
