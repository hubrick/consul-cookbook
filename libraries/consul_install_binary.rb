#
# Cookbook: consul
# License: Apache 2.0
#
# Copyright 2014-2016, Bloomberg Finance L.P.
#
require 'poise'

module ConsulCookbook
  module Provider
    # A provider which manages the binary installation of Consul.
    # @since 1.4
    class ConsulInstallBinary < Chef::Provider
      include Poise
      provides(:consul_install)
      provides(:consul_install_binary)

      def action_create
        notifying_block do
          artifact = libartifact_file "consul-#{new_resource.version}" do
            artifact_name 'consul'
            artifact_version new_resource.version
            install_path new_resource.install_path
            remote_url new_resource.binary_url % { version: new_resource.version, filename: new_resource.binary_filename('binary') }
            remote_checksum new_resource.binary_checksum 'binary'
          end

          link '/usr/local/bin/consul' do
            to join_path(artifact.current_path, 'consul')
          end
        end
      end

      def action_remove
        notifying_block do

        end
      end
    end
  end
end
