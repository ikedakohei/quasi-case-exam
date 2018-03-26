class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # method in app/models/user.rb
    @user = User.from_omniauth(request.env["omniauth.auth"])

    sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
    set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
  end

  def failure
    redirect_to root_path
  end
end