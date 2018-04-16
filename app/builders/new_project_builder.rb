class NewProjectBuilder
  SCRUM_BOARD = ['icebox', 'current', 'backlog', 'done'].freeze

  def initialize(resource = nil)
    @model = resource || Project.new
  end

  def assign_account(account)
    model.account = account
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

  def today
    @today ||= Date.today
  end
end
