class Users::RegistrationsController < Devise::RegistrationsController
  layout 'devise', only: [:new, :create]

  before_action :configure_sign_up_params, only: [:create]

  def create
    super do |resource|
      ::NewUserBuilder.new(resource)
                      .create_personal_account
                      .build
                      .save
    end
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end
end
