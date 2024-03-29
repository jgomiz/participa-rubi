# frozen_string_literal: true

Decidim.configure do |config|
  config.application_name = "Participa Rubí"
  config.mailer_sender = Rails.application.secrets.mailer_sender

  # Change these lines to set your preferred locales
  config.default_locale = :ca
  config.available_locales = [:ca, :es]

  Decidim::Verifications.register_workflow(:ws_authorization_handler) do |workflow|
    workflow.form = "WsAuthorizationHandler"
  end

  # Geocoder configuration
  # config.maps = {
  #   provider: :here,
  #   api_key: Rails.application.secrets.maps[:api_key],
  #   static: { url: "https://image.maps.ls.hereapi.com/mia/1.6/mapview" }
  # }
  # config.geocoder = {
  #   timeout: 5,
  #   units: :km
  # }

  # Custom resource reference generator method
  # config.resource_reference_generator = lambda do |resource, feature|
  #   # Implement your custom method to generate resources references
  #   "1234-#{resource.id}"
  # end

  # Currency unit
  # config.currency_unit = "€"

  # The number of reports which an object can receive before hiding it
  # config.max_reports_before_hiding = 3

  # Custom HTML Header snippets
  #
  # The most common use is to integrate third-party services that require some
  # extra JavaScript or CSS. Also, you can use it to add extra meta tags to the
  # HTML. Note that this will only be rendered in public pages, not in the admin
  # section.
  #
  # Before enabling this you should ensure that any tracking that might be done
  # is in accordance with the rules and regulations that apply to your
  # environment and usage scenarios. This feature also comes with the risk
  # that an organization's administrator injects malicious scripts to spy on or
  # take over user accounts.
  #
  config.enable_html_header_snippets = true

  # Max requests in a time period to prevent DoS attacks. Only applied on production.
  config.throttling_max_requests = 500

  # Time window in which the throttling is applied.
  config.throttling_period = 1.minute
end

Decidim.register_assets_path File.expand_path("app/packs", Rails.application.root)

Rails.application.config.i18n.available_locales = Decidim.available_locales
Rails.application.config.i18n.default_locale = Decidim.default_locale

Decidim.menu :menu do |menu|

  # Add again the Processes menu item, as we need to enforce that it's not active for
  # ParticipatoryProcessGroups pages.
  menu.item I18n.t("menu.processes", scope: "decidim"),
            Decidim::ParticipatoryProcesses::Engine.routes.url_helpers.participatory_processes_path,
            position: 2,
            if: Decidim::ParticipatoryProcess.where(organization: current_organization).published.any?,
            active: :inclusive

  # Add a Menu Item for every ParticipatoryProcessGroup in the organization.
  Decidim::ParticipatoryProcessGroup.where(organization: current_organization)
                                    .joins(:participatory_processes)
                                    .uniq
                                    .each_with_index do |group, index|
    menu.item translated_attribute(group.title),
              Decidim::ParticipatoryProcesses::Engine.routes.url_helpers.participatory_process_group_path(group),
              position: "3.#{index}".to_f,
              active: :exact
  end
end
