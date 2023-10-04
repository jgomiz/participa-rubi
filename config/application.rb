# frozen_string_literal: true

require_relative "boot"

require "decidim/rails"
# Add the frameworks used by your app that are not loaded by Decidim.
# require "action_cable/engine"
# require "action_mailbox/engine"
# require "action_text/engine"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DecidimRubi
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    config.i18n.available_locales = %i(ca es)
    config.i18n.enforce_available_locales = false
    config.i18n.fallbacks = { es: [:en], ca: [:en]}

    # Until disable_dependency_loading is finished we cannot override Decidim behaviour as some of
    # the gems might not have been loaded yet.
    initializer :decidim_overrides, after: :disable_dependency_loading do |app|

      # Overrides and enhancements to the current library
      Decidim::ParticipatoryProcesses::ParticipatoryProcessesController.prepend(ParticipatoryProcessesControllerEnhancer)
      Decidim::ParticipatoryProcesses::ProcessFiltersCell.prepend(ParticipatoryProcessesCellEnhancer)

      # In this Decidim version there is no way to identify specific menu items.
      # They are just a collection of procs. We need to remove the proc corresponding to the
      # participatory_process menu item to use ours instead defined in
      # config/initializers/decidim.rb.
      Decidim::MenuRegistry.find(:menu).configurations.reject! do |menu_item_proc|
        menu_item_proc &&
          menu_item_proc.source_location.to_s.include?("decidim/participatory_processes")
      end
    end
  end
end
