class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:login]
  before_action :authenticate_admin!, only: :admin_summary
  before_action :fetch_user, only: [:show]

  def login
  end

  def show
  end
  
  def index
    render(
      locals: {
        users: User.where.not(id: current_user&.id).all.order(name: :asc)
      }
    )
  end

  def summary
    @users = User.all.order(name: :asc)
  end

  def admin_summary
    @users = User.all.order(name: :asc)
  end

  private

  def fetch_user
    @user ||= User.find(params[:id])
  end
end
