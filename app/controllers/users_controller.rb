class UsersController < ApplicationController
  def show
    
    render(
      locals: {
        user: current_user,
        request_feedbacks: @user&.request_feedbacks,
        # give_feedbacks:  GiveFeedback.where(recipient: @user.id),
        give_feedbacks:  @user&.give_feedbacks,
      }
    )
    # binding.remote_pry
  end
  
  def index
    render(
      locals: {
        users: User.all
      }
    )
  end


  private

  def fetch_user
    @user ||= User.find(params[:id])
  end
end
