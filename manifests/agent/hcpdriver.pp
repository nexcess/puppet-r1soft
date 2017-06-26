class r1soft::agent::hcpdriver {
  # check for the hcpdriver_installed fact to prevent weirdness on fresh
  # installs
  if ($r1soft::agent::kmod_manage and $::facts['hcpdriver_installed']) {
    exec {'update hcpdriver kmod':
      command => "${r1soft::agent::kmod_tool} --get-module --silent",
      creates => $::facts['hcpdriver']['kmod_wanted'],
      notify => Service[$r1soft::agent::service_name],
    }

    unless ($::facts['hcpdriver']['is_loaded'] and $::facts['hcpdriver']['kmod_wanted'] == $::facts['hcpdriver']['kmod_selected']) {
      exec {'trigger cdp-agent restart':
        command => '/bin/true',
        notify => Service[$r1soft::agent::service_name],
      }
    }
  }
}
