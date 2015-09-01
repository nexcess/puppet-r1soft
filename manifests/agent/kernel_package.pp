class r1soft::agent::kernel_package {
  package { ["kernel-devel","kernel-devel-${kernelversion}"]:
    ensure => $r1soft::agent::cdp_agent_version,
  }
}
