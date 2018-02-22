class AddHttpBasicAuthenticationProtectedToOrganizations < ActiveRecord::Migration[5.0]

  def change
    add_column :decidim_organizations,
               :http_basic_authentication_protected,
               :boolean,
               default: false
  end

end
