module Admin
  class ProfilesController < BaseController
    def show
      @user = find_user
    end

    private

    def find_user
      params[:id].present? ? User.find(params[:id]) : current_user
    end
  end
end
