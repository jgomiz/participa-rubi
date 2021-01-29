namespace :upgrade do
  desc 'Upgrade from 0.22.0 to 0.23.1'
  task from_0_22_0_to_0_23_1: :environment do
    puts "\n\n **** START MIGRATION FROM 0.22.0 to 0.23.1 🚀 ****"

    ActiveRecord::Base.transaction do
      Decidim::Comments::Comment.find_each(&:try_update_index_for_search_resource)
      Decidim::Debates::Debate.find_each(&:try_update_index_for_search_resource)
    end

    puts "\n\n **** Finished!!! 🎉 ****"
  end

end
