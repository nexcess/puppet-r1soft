# r1soft

[![Travis](https://img.shields.io/travis/nexcess/puppet-r1soft.svg)](https://travis-ci.org/nexcess/puppet-r1soft)

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
# in hiera
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


# in your manifest
class {'::r1soft::agent':}
```


## Reference

## Limitations

## Development

Install necessary gems:
```
bundle install --path vendor/bundle
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
