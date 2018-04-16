module Admin
  class DashboardController < BaseController
    def show
      @projects = current_company.projects
    end
  end
end
