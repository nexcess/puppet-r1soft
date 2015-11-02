source 'https://rubygems.org'

group :tests do
  gem 'puppetlabs_spec_helper', '>= 0.8.2'
  gem 'puppet-lint', '>= 1.0.0'

  # https://github.com/rspec/rspec-core/issues/1864
  gem "rspec", '< 3.1.7'
  gem 'rspec-puppet', '~> 2.1'
  gem "rspec-puppet-facts"
  gem "metadata-json-lint"
end

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
