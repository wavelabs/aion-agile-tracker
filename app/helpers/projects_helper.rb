module ProjectsHelper
  Story.aasm.events.map(&:name).each do |event|
    define_method("#{event}_button".to_sym) do |story|
      link_to event, [event, story.project, story], method: :patch, class: "btn btn-#{event}"
    end
  end

  def state_button(story)
    story.aasm.events.map(&:name).inject('') do |buttons, event|
      buttons + self.public_send("#{event}_button", story)
    end.html_safe
  end

  def estimation_buttons(story)
    return unless story.feature?
    Story::POINTS.inject('') do |points, point|
      points + link_to(point, estimate_project_story_path(story.project, story, points: point), method: :patch)
    end.html_safe
  end

  def story_action_button(story)
    return if story.accepted?
    state_button(story) || estimation_buttons(story)
  end
end
