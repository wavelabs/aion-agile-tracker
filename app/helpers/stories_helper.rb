module StoriesHelper
  def icon_for_story_type(type)
    case type
    when 'bug' then 'fa-bug'
    when 'chore' then 'fa-gear'
    when 'release' then 'fa-flag'
    when 'feature' then 'fa-star'
    end
  end
end
