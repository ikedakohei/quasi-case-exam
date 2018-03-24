class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
      # set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
      if @user.sign_in_count == 1
        flash[:notice] = I18n.t 'devise.registrations.signed_up'
      else
        flash[:notice] = I18n.t 'devise.sessions.signed_in'
      end
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end