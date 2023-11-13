module ParticipatoryProcessesControllerEnhancer

  # Override: Removes participatory_group_processes from collection
  def collection
    @collection ||= paginate(participatory_processes)
  end
end
