module RailsSecureLinks
  module Generators
    class RailsSecureLinksGenerator < Rails::Generators::Base
      #hook_for :orm
      source_root File.expand_path('../templates', __FILE__)

      def copy_config_file
        template 'secure_links.rb', 'config/initializers/secure_links.rb'
      end

    end
  end
end
