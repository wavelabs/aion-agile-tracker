class NewAccountBuilder
  def initialize(resource = nil)
    @model = resource || Account.new
  end

  def set_owner(user)
    model.accounts_users.build(user: user, role: Role.admin)
    self
  end

  def assign_attributes(attrs)
    model.assign_attributes(attrs)
    self
  end

  def build
    model
  end

  def save
    model.save
  end

  private

  attr_reader :model

  def role
    Role.admin
  end
end
