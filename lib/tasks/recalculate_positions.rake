task recalculate_positions: :environment do
  Project.find_each do |project|
    project.iterations.find_each do |iteration|
      iteration.stories.chores.finished.each { |s| s.move_to_top }
      iteration.stories.accepted.each { |s| s.move_to_top }
    end
  end
end
