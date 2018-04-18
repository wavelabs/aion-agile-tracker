module Admin
  module Users
    class InvitationsController < Devise::InvitationsController
      layout 'dashboard', only: [:new, :create]

      prepend_before_action :set_env_devise_mapping
      before_action :account, only: [:new, :create]

      def create
        super do |user|
          collaborator_account = Account.create(name: user.email)
          AccountsUser.create(account: collaborator_account, user: user, role: Role.admin)
          AccountsUser.create(account: account, user: user, role: Role.user)
        end
      end

      private

      def set_env_devise_mapping
        request.env["devise.mapping"] = Devise.mappings[:user]
      end

      def account
        @account ||= current_user.accounts.find(params[:account_id])
      end

      def after_invite_path_for(inviter, invitee)
        accounts_path
      end

      def update_resource_params
        params.require(:user).permit(:password, :password_confirmation, :invitation_token, :username)
      end
    end
  end
end
