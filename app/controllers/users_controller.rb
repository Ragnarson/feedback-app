class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:login]
  before_action :fetch_user, only: [:show]

  def login
  end

  def show
  end
  
  def index
    render(
      locals: {
        users: User.where.not(id: current_user&.id).all
      }
    )
  end


  private

  def fetch_user
    @user ||= User.find(params[:id])
  end
end
