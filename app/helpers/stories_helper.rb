module StoriesHelper
  def icon_for_story_type(type)
    case type
    when 'bug' then 'fa-bug'
    when 'chore' then 'fa-gear'
    when 'release' then 'fa-flag'
    when 'feature' then 'fa-star'
    end
  end

  def label_list_to_html(labels)
    labels.map do |label|
      tag.span label, class: 'tag'
    end.join('').html_safe
  end

  def label_list_links(story)
    story.labels.map do |label|
      link_to label.name, [story.project, :stories, q: { labels_name_in: label.name }]
    end.join(', ').html_safe
  end


  def owner_list_links(story)
    story.owners.map do |owner|
      link_to owner.abbr, [story.project, :stories, q: { owner_ids_in: owner.id }]
    end.join(', ').html_safe
  end

  Story.aasm.events.map(&:name).each do |event|
    define_method("#{event}_button".to_sym) do |story|
      link_to event.to_s.titleize, [event, story.project, story], method: :patch, class: "btn btn-sm btn-#{event}"
    end
  end

  def state_button(story)
    return if story.feature? && !story.estimated?
    story.aasm.events.map(&:name).map do |event|
      self.public_send("#{event}_button", story)
    end.join('&nbsp;').html_safe
  end

  def estimation_buttons(story)
    return unless story.feature?
    dropdown_button = tag.button type: 'button', class: 'btn btn-secondary btn-sm dropdown-toggle', data: { toggle: 'dropdown' } do
      tag.i class: 'fa fa-clock-o'
    end

    content = tag.div class: 'dropdown-menu' do
      Story::POINTS.map do |point|
        link_to(point, estimate_project_story_path(story.project, story, points: point), method: :patch, class: 'dropdown-item')
      end.join('').html_safe
    end

    tag.div(class: 'dropdown') { dropdown_button + content }
  end

  def story_action_button(story)
    return if story.accepted?
    state_button(story) || estimation_buttons(story)
  end
end
