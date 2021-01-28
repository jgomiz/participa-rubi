namespace :upgrade do
  desc 'Upgrade from 0.19.1 to 0.20.1'
  task from_0_19_1_to_0_20_1: :environment do
    puts "\n\n **** START MIGRATION FROM 0.19.1 to 0.20.1 🚀 ****"

    ActiveRecord::Base.transaction do
      Decidim::Assembly.find_each(&:add_to_index_as_search_resource)
      Decidim::ParticipatoryProcess.find_each(&:add_to_index_as_search_resource)
      # Decidim::Conference.find_each(&:add_to_index_as_search_resource)
      # Decidim::Consultation.find_each(&:add_to_index_as_search_resource)
      # Decidim::Initiative.find_each(&:add_to_index_as_search_resource)
      Decidim::Debates::Debate.find_each(&:add_to_index_as_search_resource)
      Decidim::Budgets::Project.find_each(&:add_to_index_as_search_resource)
      Decidim::Blogs::Post.find_each(&:add_to_index_as_search_resource)
    end

    puts "\n\n **** Finished!!! 🎉 ****"
  end

end
