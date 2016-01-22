#
# Cookbook: consul
# License: Apache 2.0
#
# Copyright 2014-2016, Bloomberg Finance L.P.
#
require 'poise'

module ConsulCookbook
  module Provider
    # A provider which manages the source installation of Consul.
    # @since 1.4
    class ConsulInstallSource < Chef::Provider
      include Poise
      provides(:consul_install)
      provides(:consul_install_source)

      def action_create
        notifying_block do
          include_recipe 'golang::default'

          source_dir = directory join_path(new_resource.install_path, 'consul', 'src') do
            recursive true
            owner new_resource.user
            group new_resource.group
            mode '0755'
          end

          git join_path(source_dir.path, "consul-#{new_resource.version}") do
            repository new_resource.source_url
            reference new_resource.version
            action :checkout
          end

          golang_package 'github.com/hashicorp/consul' do
            action :install
          end

          directory join_path(new_resource.install_path, 'bin') do
            recursive true
            owner new_resource.user
            group new_resource.group
            mode '0755'
          end

          link join_path(new_resource.install_path, 'bin', 'consul') do
            to join_path(source_dir.path, "consul-#{new_resource.version}", 'consul')
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
