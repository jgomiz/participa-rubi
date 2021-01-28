namespace :upgrade do
  desc 'Upgrade from 0.16.1 to 0.18.1'
  task from_0_16_1_to_0_18_1: :environment do
    puts "\n\n **** START MIGRATION FROM 0.16.1 to 0.18.1 🚀 ****"

    puts " \n == 0.16.1 required tasks 💻 =="
    Decidim::UserBaseEntity.find_each do |entity|
			follower_count = Decidim::Follow.where(followable: entity).count
			following_count = Decidim::Follow.where(decidim_user_id: entity.id).count

			# We use `update_columns` to skip Searchable callbacks
			entity.update_columns(
				followers_count: follower_count,
				following_count: following_count
			)
		end

		
    puts " \n == 0.18.0 required tasks 💪 =="
    days = (Date.parse(2.months.ago.to_s)..Date.yesterday).uniq
    Decidim::Organization.find_each do |org|
			old_metrics = Decidim::Metric.where(organization: org).where(metric_type: "participants")
			days.each do |day|
				new_metrics = Decidim::Metrics::ParticipantsMetricManage.new(day.to_s, org)
				ActiveRecord::Base.transaction do
					old_metrics.where(day: day).delete_all
					new_metrics.save
				end
			end
		end

    puts " \n == Fixe permissions in some Decidim::Component entities 👾 =="
    puts "    Note: when the permission has the value { 'authorization_handler_name' => nil } causes problems"
    Decidim::Component.all.select { |a| a&.permissions&.value?('authorization_handler_name' => nil) }.each do |component|
      component.permissions.each do |key, value|
        component.permissions[key].except!('authorization_handler_name') if value == { 'authorization_handler_name' => nil }
        component.save
        puts " - Component #{component.id} removed { 'authorization_handler_name' => nil } to the key #{key}"
      end
    end


    puts "\n\n **** Finished!!! 🎉 ****"
  end

end
