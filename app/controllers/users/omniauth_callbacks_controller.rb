class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :authenticate, only: %i[facebook twitter github]

  def facebook
  end

  def twitter
  end

  def github
  end

  def failure
    redirect_to root_path
  end

  private

  def authenticate
    # app/models/user.rbにあるメソッドを使用
    user = User.from_omniauth(request.env["omniauth.auth"])
    sign_in_and_redirect user, event: :authentication
    flash[:notice] = user.sign_in_count == 1 ? (I18n.t 'devise.registrations.signed_up')
                                             : (I18n.t 'devise.sessions.signed_in')
  end
end