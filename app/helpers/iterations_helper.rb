module IterationsHelper
  MAX_NUMBER_ACCEPTED_STORIES = 3.freeze

  def iteration_classes(iteration)
    classes = []
    classes << 'Iteration--collapsed' unless iteration.current?
    classes << 'Iteration--hide-accepted' if iteration.count_story_done > MAX_NUMBER_ACCEPTED_STORIES
    classes.join(' ')
  end
end
