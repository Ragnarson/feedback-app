class GiveFeedbacksController < ApplicationController
  before_action :fetch_feedback_offer, only: [:accept, :decline]

  def create
    give_feedback = current_user.give_feedbacks.new(give_feedback_params)

    if give_feedback.save
      # redirect_to(root_path, notice: "Request has been sent")
      # redirect_to root_path
      redirect_to "/"
    else
      flash[:alert] = give_feedback.errors.full_messages.to_sentence
      redirect_back fallback_location: root_path
    end
  end

  def accept
    @feedback_offer.update(status: :accepted)
    redirect_back fallback_location: root_path
  end

  def decline
    @feedback_offer.update(status: :declined)
    redirect_back fallback_location: root_path
  end

  private

  def give_feedback_params
    params.require(:give_feedback).permit(:feedback_type, :recipient)
  end

  def fetch_feedback_offer
    # catch error + alert z ridrectem
    @feedback_offer = current_user.give_feedbacks.find(params[:id])
  end
end
