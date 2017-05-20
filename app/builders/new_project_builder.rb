class NewProjectBuilder
  def initialize(resource = nil)
    @model = resource || Project.new
  end

  def add_default_story_states
    @model.story_states = DefaultStoryStatesBuilder.build
    self
  end

  def assign_company(company)
    model.company = company
    self
  end

  def assign_attributes(attrs)
    model.assign_attributes(attrs)
    self
  end

  def build
    model
  end

  private

  attr_reader :model
end
