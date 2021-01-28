module ParticipatoryProcessesControllerEnhancer

  # Override: Removes participatory_group_processes from collection
  def collection
    @collection ||= participatory_processes.to_a.flatten
  end
end
