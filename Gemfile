source 'https://rubygems.org'

group :tests do
  gem 'puppetlabs_spec_helper'
  gem 'puppet-lint'
  gem "rspec"
  gem 'rspec-puppet'
  gem "rspec-puppet-facts"
  gem "metadata-json-lint"
end

# json_pure 2.0.2 added a requirement on ruby >= 2. We pin to json_pure 2.0.1
# if using ruby 1.x
gem 'json_pure', '<=2.0.1', :require => false if RUBY_VERSION =~ /^1\./

group :development do
  gem "puppet-blacksmith"
end

group :system_tests do
  if beaker_version = ENV['BEAKER_VERSION']
    gem 'beaker', *location_for(beaker_version)
  end
  if beaker_rspec_version = ENV['BEAKER_RSPEC_VERSION']
    gem 'beaker-rspec', *location_for(beaker_rspec_version)
  else
    gem 'beaker-rspec',  :require => false
  end
  gem 'serverspec',    :require => false
  gem 'beaker-puppet_install_helper', :require => false
end

if facterversion = ENV['FACTER_GEM_VERSION']
  gem 'facter', facterversion, :require => false
else
  gem 'facter', :require => false
end

if puppetversion = ENV['PUPPET_GEM_VERSION']
  gem 'puppet', puppetversion, :require => false
else
  gem 'puppet', :require => false
end
