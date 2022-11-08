class SessionsController < ApplicationController
  # skip_before_action :authenticate_user!

  def create
    # return redirect_to root_path unless domain.present?

    # if blacklisted?(email)
    #   redirect_to root_url, alert: "Authentication error: Email not whitelisted"
    # else
    #   agency = Agency.find_or_create_by!(domain: domain)
      @user = User.find_or_create_from_auth(auth: auth)

      cookies.permanent.signed[:user_id] = @user.id
      redirect_to root_path, notice: "Signed in"
    # end
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

  def domain
    @domain ||= auth[:extra][:raw_info][:hd]
  end

  def email
    @email ||= auth[:extra][:raw_info][:email]
  end

  def blacklisted?(email)
    BlacklistedUser.exists?(email: email)
  end
end
