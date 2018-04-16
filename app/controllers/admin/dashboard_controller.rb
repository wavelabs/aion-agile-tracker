module Admin
  class DashboardController < BaseController
    def show
      @projects = current_account.projects
    end
  end
end
