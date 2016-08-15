# r1soft

[![Travis](https://img.shields.io/travis/nexcess/puppet-r1soft.svg)](https://travis-ci.org/nexcess/puppet-r1soft)
[![Puppet Forge](https://img.shields.io/puppetforge/v/nexcess/r1soft.svg)](https://forge.puppetlabs.com/nexcess/r1soft)

#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference ](#reference)
5. [Limitations](#limitations)
6. [Development](#development)
7. [Copyright](#copyright)

## Overview

This module installs and configures the r1soft server backup agent.

## Module Description

This module installs the r1soft server backup agent. It will install the r1soft
yum repository, the kernel-devel pacakge, the cdp kernel module, install keys
for r1soft backup servers, and start the r1soft agent.

## Usage

### Beginning with r1soft::agent

To install the r1soft agent with keys for 198.51.100.2 and 198.51.100.3, and
ensuring a key is absent for 198.51.100.4:

```
class {'::r1soft::agent':
  keys => {'198.51.100.2' => {key => "-----BEGIN PUBLIC KEY-----\nDEADBEEF\n-----END PUBLIC KEY-----",},
           '198.51.100.3' => {key => "-----BEGIN PUBLIC KEY-----\nCAFEFOOD\n-----END PUBLIC KEY-----",},
           '198.51.100.4' => {ensure => 'absent'}}
}
```

It looks much better and is much easier to manage in hiera:

```
# in hiera.yaml
r1soft::agent::keys:
  198.51.100.2:
    key: |
      -----BEGIN PUBLIC KEY-----
      DEADBEEFDEADBEEFDEADBEEFDEADBEEFDEADBEEF
      FBADBEEFFBADBEEFFBADBEEFFBADBEEFFBADBEEF
      BADDCAFEBADDCAFEBADDCAFEBADDCAFEBADDCAFE
      -----END PUBLIC KEY-----
  198.51.100.3:
    key: |
      -----BEGIN PUBLIC KEY-----
      CAFEFOODCAFEFOODCAFEFOODCAFEFOODCAFEFOOD
      B105F00DB105F00DB105F00DB105F00DB105F00D
      C00010FFC00010FFC00010FFC00010FFC00010FF
      -----END PUBLIC KEY-----
  198.51.100.4:
    ensure: absent


# in your manifest.pp
class {'::r1soft::agent':}
```

### Beginning with r1soft::server

To install the r1soft server with the password 'insecure':

```
class {'::r1soft::server':
  admin_pass => 'insecure',
}
```

## Reference

### r1soft::agent parameters

#### `repo_install`
Specify if you want the module to install the r1soft repository. Default value: true

#### `package_version`
Specify the version of r1soft agent to install. Default value: 'present'

#### `package_name`
Specify the name of the r1soft agent package. Default value: 'serverbackup-agent'

#### `kernel_devel_install`
Specify if you want the module to install the kernel-devel package which is needed by r1soft agent. Default value: true

#### `kernel_devel_package_names`
Specify the kernel-devel package name. Default value: kernel-devel-${::kernelrelease}

#### `service_manage`
Specify if you want to the module to manage the r1soft agent service. Default value: true

#### `service_name`
Specify the name of the r1soft agent service. Default value: 'cdp-agent'

#### `service_ensure`
Specify the ensure value of the r1soft agent service. Default value: 'running'

#### `service_enable`
Specify the enable value of the r1soft agent service. Default value: true

#### `keys`
Specify a list of keys to place on the r1soft agent server. Default value: empty

#### `keys_purge_unmanaged`
Specify if you want to purge all keys not managed by puppet: Default value: false


### r1soft::server parameters

#### `repo_install`
Specify if you want the module to install the r1soft repository. Default value: true

#### `package_version`
Specify the version of r1soft server to install. Default value: 'present'

#### `package_name`
Specify the name of the r1soft server package. Default value: 'serverbackup-agent'

#### `service_manage`
Specify if you want to the module to manage the r1soft server service. Default value: true

#### `service_name`
Specify the name of the r1soft server service. Default value: 'cdp-agent'

#### `service_ensure`
Specify the ensure value of the r1soft server service. Default value: 'running'

#### `service_enable`
Specify the enable value of the r1soft server service. Default value: true

#### `admin_user`
Specify the admin user name. Default value: 'admin'

#### `admin_pass`
Specify the admin user password. **This needs to be set for r1soft server to work** Default value: false

#### `max_mem`
Specify max_mem for r1soft server. Default value: undef

#### `http_port`
Specify http port for r1soft server. Default value: 80

#### `https_port`
Specify https port for r1soft server. Default value: 443


### r1osft::repo parameters

#### `repo_baseurl`
Specify the baseurl for the yum repo. Default value: 'http://repo.r1soft.com/yum/stable/$basearch/'

http is used instead of https because r1soft doesn't include the full chain for
their certificate. CentOS has the root certificate but not the intermediate
certificate. It is
[web server's responsibility to send intermediate certificates](https://wiki.mozilla.org/CA:FAQ#Why_does_SSL_handshake_fail_due_to_missing_intermediate_certificate.3F). Without
the intermediate certificate, the TLS connection and yum fail. See
[ssllabs's test](https://www.ssllabs.com/ssltest/analyze.html?d=repo.r1soft.com
for more info.

#### `repo_enabled`
Specify the enable value for the yum repo. Default value: true

#### `repo_gpgcheck`
Specify the gpgcheck value for the yum repo. Default value: false

r1soft does not sign their RPMs. We have already opened a ticket with them about
it.

### Facts

* r1soft_agent_version: r1soft version and build number
* r1soft_agent_version_short: r1soft version number
* r1soft_agent_version_long: r1soft version number, build number, and build date

## Limitations

The module works with currently supported versions of CentOS and RHEL, It has
been tested on CentOS. It can probably work on Oracle Linux and Scientific Linux
with minimal work.

## Development

Install necessary gems:
```
bundle install --path vendor/bundle
```

Check syntax of all puppet manifests, erb templates, and ruby files:
```
bundle exec rake validate
```

Run puppetlint on all puppet files:
```
bundle exec rake lint
```

Run spec tests in a clean fixtures directory
```
bundle exec rake spec
```

Run acceptance tests:
```
BEAKER_set=centos-7-x64 bundle exec rake acceptance
```

## Copyright

Copyright 2015 [Nexcess](https://www.nexcess.net/)

```
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
