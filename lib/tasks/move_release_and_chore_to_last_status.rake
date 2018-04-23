task move_releases_and_chore_to_last_status: :environment do
  Project.find_each do |project|
    project.iterations.order(:start_date).find_each do |iteration|
      iteration.stories.accepted.releases.update_all(story_state: 'finished')
      iteration.stories.accepted.chores.update_all(story_state: 'finished')
      iteration.stories.rejected.releases.update_all(story_state: 'finished')
    end
  end
end
