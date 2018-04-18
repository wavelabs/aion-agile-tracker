module Admin
  class DashboardController < BaseController
    def show
      @projects = current_user.projects
    end
  end
end
