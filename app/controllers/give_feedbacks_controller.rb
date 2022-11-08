class GiveFeedbacksController < ApplicationController
  def create
    give_feedback = current_user.give_feedbacks.new(give_feedback_params)
binding.remote_pry
    if give_feedback.save
      # binding.remote_pry
      # redirect_to(root_path, notice: "Request has been sent")
      redirect_to root_path
    else
      flash[:alert] = give_feedback.errors.full_messages.to_sentence
      redirect_back fallback_location: root_path
    end
  end

  def accept
    fetch_give_feedback.update(status: :accepted)
  end

  def decline
    fetch_give_feedback.update(status: :declined)
  end

  private

  def give_feedback_params
    params.require(:give_feedback).permit(:feedback_type, :recipient)
  end

  def fetch_give_feedback
    current_user.give_feedbacks.find(params[:id])
  end
end
