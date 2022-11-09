class RequestFeedbacksController < ApplicationController
  before_action :fetch_feedback_request, only: [:accept, :decline]
  before_action :fetch_current_user_feedback_request, only: [:destroy]

  def create
    request_feedback = current_user.request_feedbacks.new(request_feedback_params)

    if request_feedback.save
      redirect_to root_path, notice: "Your request for a feedback successfully has been sent"
    else
      flash[:alert] = request_feedback.errors.full_messages.to_sentence
      redirect_back fallback_location: root_path
    end
  end

  def both_creation
    request_feedback = current_user.request_feedbacks.new(request_feedback_params)
    give_feedback = current_user.give_feedbacks.new(request_feedback_params)
    
    if request_feedback.save && give_feedback.save
      redirect_to root_path, notice: "Your request and offer feedback successfully has been sent"
    else
      flash[:alert] = request_feedback.errors.full_messages.to_sentence
      redirect_back fallback_location: root_path
    end
  end

  def accept
    @request_feedback.update(status: :accepted)
    redirect_back fallback_location: root_path
  end

  def decline
    @request_feedback.update(status: :declined)
    redirect_back fallback_location: root_path
  end

  def destroy
    @current_user_feedback_request.destroy!
    redirect_to fallback_location: root_path
  end

  private

  def request_feedback_params
    params.require(:request_feedback).permit(:feedback_type, :recipient)
  end

  def fetch_current_user_feedback_request
    # catch error + alert z ridrectem
    @current_user_feedback_request = current_user.request_feedbacks.find(params[:id])
  end

  def fetch_feedback_request
    @request_feedback = current_user.feedback_requests.find(params[:id])
  end
end
