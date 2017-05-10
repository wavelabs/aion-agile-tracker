class NewUserBuilder
  def initialize(resource)
    @model = resource
  end

  def add_company_relationship
    CompaniesUser.find_or_create_by(company: company, user: model, role: role)
    self
  end

  def build
    model
  end

  private

  attr_reader :model

  def company
    Company.find_or_create_by(name: model.company_name)
  end

  def company_user
    @model.companies_users.first
  end

  def role
    return Role.admin if company.users.size == 1
    Role.user
  end
end
