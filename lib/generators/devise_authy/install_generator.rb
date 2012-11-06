module DeviseAuthy
  module Generators
    # Install Generator
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      class_option :haml, :type => :boolean, :required => false, :default => false, :desc => "Generate views in Haml"
      class_option :sass, :type => :boolean, :required => false, :default => false, :desc => "Generate stylesheet in Sass"

      desc "Install the devise authy extension"

      def add_configs
        inject_into_file "config/initializers/devise.rb", "\n  # ==> Devise Authy Authentication Extension\n  # Configure extension for devise\n\n" +
        "  # How long should the user have to enter their token. To change the default, uncomment and change the below:\n" +
        "  # config.authy_expires_at = 1.month\n\n" +
        "\n", :before => /end[ |\n|]+\Z/
      end

      def copy_locale
        copy_file "../../../config/locales/en.yml", "config/locales/devise.authy.en.yml"
      end

      def copy_views
        if options.haml?
          copy_file '../../../app/views/devise/register.html.haml', 'app/views/devise/devise_authy/register.html.haml'
          copy_file '../../../app/views/devise/show.html.haml', 'app/views/devise/devise_authy/show.html.haml'
        else
          copy_file '../../../app/views/devise/register.html.erb', 'app/views/devise/devise_authy/register.html.erb'
          copy_file '../../../app/views/devise/show.html.erb', 'app/views/devise/devise_authy/show.html.erb'
        end
      end

      def copy_assets
        if options.sass?
          copy_file '../../../app/assets/stylesheets/devise_authy.sass', 'app/assets/stylesheets/devise_authy.sass'
        else
          copy_file '../../../app/assets/stylesheets/devise_authy.css', 'app/assets/stylesheets/devise_authy.css'
        end
      end
    end
  end
end