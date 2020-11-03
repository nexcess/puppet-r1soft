## 2.2.0 [PR Pending] - 2020-11-03
- Replaced all occurances of "cdp" with "sbm"
- Fixed some incorrect references on readme.md
- `kmod_manage` now defaults to `true`
- Fixed tests

## 2.1.0 - 2017-06-27
- add management of the hcpdriver kmod

## 2.0.0 - 2016-08-20
- the managemnt of the r1sfot repo repo is a separate class now. it can still be
  installed through the agent.
- the following parameters were moved from r1soft::agent to r1soft::repo:
  * repo_baseurl
  * repo_enabled
  * repo_gpgcheck
- the following parameters were renamed in r1soft::agent:
  * cdp_agent_package_version -> package_version
  * cdp_agent_package_name -> package_name
- added r1soft::server class
- added testing with beaker and travis

## 1.0.0 - 2015-12-13
- initial release
