class SessionsController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    @user = User.find_or_create_from_auth(auth: auth)

    cookies.permanent.signed[:user_id] = @user.id
    redirect_to users_path, notice: "Signed in"
  end

  def destroy
    cookies.signed[:user_id] = nil
    redirect_to root_url, notice: "Signed out"
  end

  def failure
    redirect_to root_url, alert: "Authentication error: #{params[:message].humanize}"
  end

  private

  def auth
    @auth ||= request.env["omniauth.auth"]
  end

  def email
    @email ||= auth[:extra][:raw_info][:email]
  end
end
