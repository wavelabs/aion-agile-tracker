class FinishIteration
  def self.call(iteration)
    project           = iteration.project
    current_iteration = project.current_iteration

    iteration.stories.not_accepted.but_releases.update_all(iteration_id: current_iteration.id)
    iteration.stories.not_accepted.releases.update_all(story_state: 'rejected')
    iteration.update(velocity: iteration.points_done)
  end
end
