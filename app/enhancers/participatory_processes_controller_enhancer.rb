module ParticipatoryProcessesControllerEnhancer

  # Override: Removes participatory_group_processes from collection
  def collection
    @collection ||= participatory_processes.to_a.flatten
  end


  # Override: Removes participatory_group_processes from count
  def process_count_by_filter
    return @process_count_by_filter if @process_count_by_filter

    @process_count_by_filter = %w(active upcoming past).inject({}) do |collection_by_filter, filter_name|
      processes = filtered_participatory_processes(filter_name).query.where(decidim_participatory_process_group_id: nil)
      collection_by_filter.merge(filter_name.to_s => processes.count)
    end
    @process_count_by_filter["all"] = @process_count_by_filter.values.sum
    @process_count_by_filter
  end
end
