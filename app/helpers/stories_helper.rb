module StoriesHelper
  def story_type_icon(type)
    icon = case type
           when 'bug' then 'fa-bug'
           when 'chore' then 'fa-gear'
           when 'release' then 'fa-flag'
           when 'feature' then 'fa-star'
           end

    tag.i class: "fa #{icon}"
  end

  def label_list_to_html(labels)
    labels.map do |label|
      tag.span label, class: 'tag'
    end.join('').html_safe
  end

  def label_list_links(story)
    story.labels.map do |label|
      link_to label.name, [story.project, :stories, q: { labels_name_in: label.name }], class: 'Story-label'
    end.join(', ').html_safe
  end


  def owner_list_links(story)
    story.owners.map do |owner|
      link_to owner.abbr, [story.project, :stories, q: { owner_ids_in: owner.id }], class: 'Story-owner'
    end.join(', ').html_safe
  end

  Story.aasm.events.map(&:name).each do |event|
    define_method("#{event}_button".to_sym) do |story|
      link_to event.to_s.titleize, [event, story.project, story], method: :patch, class: "btn btn-sm btn-#{event}"
    end
  end

  def state_button(story)
    return if story.feature? && !story.estimated?
    story.aasm.events(:permitted => true).map(&:name).map do |event|
      self.public_send("#{event}_button", story)
    end.join('&nbsp;').html_safe
  end

  def estimation_buttons(story)
    return unless story.feature?
    dropdown_button = tag.button type: 'button', class: 'btn btn-secondary btn-sm dropdown-toggle', data: { toggle: 'dropdown' } do
      tag.i class: 'fa fa-clock-o'
    end

    content = tag.div class: 'dropdown-menu' do
      Story::POINTS[1..-1].map do |point|
        link_to(pluralize(point, 'point'), estimate_project_story_path(story.project, story, points: point), method: :patch, class: 'dropdown-item')
      end.join('').html_safe
    end

    tag.div(class: 'dropdown') { dropdown_button + content }
  end

  def story_action_button(story)
    return if story.accepted? || (story.release? && story.rejected?)
    state_button(story) || estimation_buttons(story)
  end

  def story_classes(story)
    classes = []
    classes << 'Story--draggable' unless story.last_status?
    classes << "Story--#{story.story_type}"
    classes << "Story--#{story.story_state}"
    classes.join(' ')
  end

  def humanize_story_points(points)
    points.map { |point| [ pluralize(point, 'point'), point ] }
          .tap { |points| points[0][0] = 'Unestimated' }
  end

  def disable_estimations?(story)
    !story.feature? && !story.new_record?
  end

  def disable_release_date?(story)
    !story.release? || story.new_record?
  end
end
