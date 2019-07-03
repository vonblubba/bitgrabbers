class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
  	redirect_to root_path and return unless request.env["omniauth.auth"]["info"]["email"] == "oscar.riva@gmail.com" || request.env["omniauth.auth"]["info"]["email"] == "eaoveyabhp_1561787114@tfbnw.net"
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to root_path
    end
  end

  def failure
    redirect_to root_path
  end
end