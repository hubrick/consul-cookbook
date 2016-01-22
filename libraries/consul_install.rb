#
# Cookbook: consul
# License: Apache 2.0
#
# Copyright 2014-2016, Bloomberg Finance L.P.
#
require 'poise'

module ConsulCookbook
  module Resource
    # A resource which manages install of Consul.
    # @since 1.4
    class ConsulInstall < Chef::Resource
      include Poise
      provides(:consul_install)
      actions(:create, :remove)
      default_action(:create)

      property(:version, kind_of: String, name_attribute: true)
      property(:package_name, kind_of: String)
      property(:remote_url, kind_of: String)
      property(:remote_checksum, kind_of: String)
      property(:source_url, kind_of: String)
    end
  end

  module Provider
    # @since 1.4
    class ConsulInstallPackage < Chef::Provider
      include Poise
      provides(:consul_install)
      provides(:consul_install_package)

      def action_create
        notifying_block do
          package new_resource.package_name do
            version new_resource.version
          end
        end
      end

      def action_remove
      end
    end
  end
end
