#
# Cookbook: consul
# License: Apache 2.0
#
# Copyright 2014-2016, Bloomberg Finance L.P.
#
require 'poise'

module ConsulCookbook
  module Provider
    # @since 1.4
    class ConsulInstallUi < Chef::Provider
      include Poise
      provides(:consul_install_ui)

      def action_create
      end

      def action_remove
      end
    end
  end
end
