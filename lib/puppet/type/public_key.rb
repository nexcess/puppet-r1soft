Puppet::Type.newtype(:public_key) do
  @doc = 'Add the public key(s) of an r1soft server(s) to an agent.'

  ensurable

  newparam(:hostname) do
    desc 'Hostname of the r1soft server to retrieve the key from.'
    isnamevar
  end

  newparam(:key) do
    desc 'The public key of an r1soft server.'
  end

end
