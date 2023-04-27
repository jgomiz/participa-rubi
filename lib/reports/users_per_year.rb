#frozen_string_literal: true

CSV.open("/app/storage/decidim_users_per_year.csv", "wb") do |csv|
  csv << %w(year total)
  Decidim::User.where(admin: false).where(deleted_at: nil).where(decidim_organization_id: 2).group("EXTRACT(year from created_at)").select("count(1), EXTRACT(year from created_at) AS year").sort_by(&:year).each do |r|
    csv << [r.year.to_i, r.count]
  end
end
