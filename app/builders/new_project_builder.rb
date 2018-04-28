class NewProjectBuilder
  def initialize(resource = nil)
    @model = resource || Project.new
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
