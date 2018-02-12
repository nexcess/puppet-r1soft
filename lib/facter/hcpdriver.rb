Facter.add(:hcpdriver_installed) do
    confine :kernel => 'Linux'

    setcode do
        File.executable? '/usr/sbin/hcp'
    end
end

Facter.add(:hcpdriver) do
    confine :kernel => 'Linux'
    confine :hcpdriver_installed => true

    setcode do
        fact_data = Hash.new
        fact_data[:is_loaded] = File.exist? '/sys/module/hcpdriver/version'
        if fact_data[:is_loaded]
            fact_data[:version] = File.read('/sys/module/hcpdriver/version').strip
        end
        fact_data[:kmod_wanted] = '/lib/modules/r1soft/hcpdriver-cki-%s.ko' % Facter.value(:kernelrelease)
        fact_data[:kmod_wanted_is_built] = File.exist? fact_data[:kmod_wanted]
        fact_data[:kmod_selected] = File.exist?('/lib/modules/r1soft/hcpdriver.o') \
            ? File.readlink('/lib/modules/r1soft/hcpdriver.o') \
            : ''
        fact_data
    end
end
