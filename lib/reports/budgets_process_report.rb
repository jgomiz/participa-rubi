# https://github.com/PopulateTools/issues/issues/1754
# The client wants to get a list of participants who voted proposals in a Process with their name, email in order to review & possible to contact them

require "csv"
PROCESS_ID = 22

CSV.open("/app/storage/participants.csv", "wb") do |csv|
  csv << ["Name", "Email"]
  Decidim::Budgets::Order.where(decidim_budgets_budget_id: PROCESS_ID).map(&:user).uniq.each do |user|
    csv << [user.name, user.email]
  end
end
