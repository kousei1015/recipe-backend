class V1::Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController
  before_action :sign_up_params

  private
  def sign_up_params
    params.permit(:email, :password, :password_confirmation, :name, :avatar, keys: %i[avatar])
  end
  
  def account_update_params
    params.permit(:email, :password, :password_confirmation, :name, :avatar)
  end
end
