class DefaultStoryStatesBuilder
  STATES = %w(unestarted started finished delivered rejected accepted).freeze

  def self.build
    STATES.map do |state|
      StoryState.new(name: state, display_name: state.titleize)
    end
  end
end
