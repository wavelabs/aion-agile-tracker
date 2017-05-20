Role.find_or_create_by(name: 'user', display_name: 'user')
Role.find_or_create_by(name: 'admin', display_name: 'admin')

STORY_TYPES = [
  { name: 'feature', display_name: 'Feature', icon: 'star' },
  { name: 'chore', display_name: 'Chore', icon: 'chore' },
  { name: 'bug', display_name: 'Bug', icon: 'bug' },
  { name: 'epic', display_name: 'Epic', icon: 'flag' }
]

STORY_TYPES.each do |st|
  StoryType.create_with(st).find_or_create_by(name: st[:name])
end
