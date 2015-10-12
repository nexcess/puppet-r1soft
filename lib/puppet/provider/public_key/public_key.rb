Puppet::Type.type(:public_key).provide(:public_key) do
  def create
    notice "Adding key for the host: #{resource[:hostname]}"
    File.open('/usr/sbin/r1soft/conf/server.allow/' + resource[:hostname], 'w') do |f|
      f.write(resource[:key])
    end
  end

  def destroy
    notice "Removing key for the host: #{resource[:hostname]}"
    File.delete('/usr/sbin/r1soft/conf/server.allow/' + resource[:hostname])
  end

  def exists?
    #require 'ftools'
    File.exists?('/usr/sbin/r1soft/conf/server.allow/' + resource[:hostname]) &&
      IO.read('/usr/sbin/r1soft/conf/server.allow/' + resource[:hostname]) == resource[:key]
  end

end
