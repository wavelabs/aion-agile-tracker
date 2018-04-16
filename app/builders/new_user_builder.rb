class NewUserBuilder
  def initialize(resource)
    @model = resource
  end

  def create_personal_account
    account = Account.find_or_create_by(name: model.username)
    relation = account.accounts_users.create(user: model, role: Role.admin)
    self
  end

  def build
    model
  end

  private

  attr_reader :model
end
