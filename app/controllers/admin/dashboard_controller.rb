module Admin
  class DashboardController < BaseController
    def show
      @projects = current_user.projects.order(updated_at: :desc)
    end
  end
end
