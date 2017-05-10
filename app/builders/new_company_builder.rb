class NewCompanyBuilder
  def initialize(resource = nil)
    @model = resource || Company.new
  end

  def add_user(user)
    model.companies_users.build(user: user, role: role)
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

  def role
    Role.admin
  end
end
