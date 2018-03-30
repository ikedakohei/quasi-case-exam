class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # app/models/user.rbにあるメソッドを使用
    @user = User.from_omniauth(request.env["omniauth.auth"])
    sign_in_and_redirect @user, event: :authentication
    flash[:success] = @user.sign_in_count == 1 ? (I18n.t 'devise.registrations.signed_up')
                                               : (I18n.t 'devise.sessions.signed_in')
  end

  def failure
    redirect_to root_path
  end
end