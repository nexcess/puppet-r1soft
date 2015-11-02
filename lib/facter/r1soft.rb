if File::exist?('/usr/sbin/r1soft/bin/cdp') then

  r1soft_version_output = Facter::Util::Resolution.exec('/usr/sbin/r1soft/bin/cdp --version')

  Facter.add(:r1soft_agent_version_short) do
    setcode do
      r1soft_version_output.split[4]
    end
  end

  Facter.add(:r1soft_agent_version) do
    setcode do
      r1soft_version_output.split.values_at(4,6).join('-')
    end
  end

  Facter.add(:r1soft_agent_version_long) do
    setcode do
      r1soft_version_output.split[4..-1].join(' ')
    end
  end

end
