class r1soft::agent inherits r1soft::params {

  class{'::r1soft::repo':}
  class{'::r1soft::agent::kernel_package':}
  class{'::r1soft::agent::install':}
  class{'::r1soft::agent::kernel_module':}
  class{'::r1soft::agent::service':}
} 
