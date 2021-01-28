module ParticipatoryProcessesCellEnhancer

  # Override: Removes participatory_group_processes from count
  def process_count_by_filter
    return @process_count_by_filter if @process_count_by_filter

    @process_count_by_filter = %w(active upcoming past).inject({}) do |collection_by_filter, filter_name|
      filtered_processes = filtered_processes(filter_name).results
      processes = filtered_processes.groupless
      collection_by_filter.merge(filter_name => processes.count)
    end
    @process_count_by_filter["all"] = @process_count_by_filter.values.sum
    @process_count_by_filter
  end
end
