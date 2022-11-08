class RequestFeedbacksController < ApplicationController  
  def create
    request_feedback = current_user.request_feedbacks.new(request_feedback_params)

    if request_feedback.save
      redirect_to(root_path, notice: "Request has been sent")
    else
      flash[:alert] = request_feedback.errors.full_messages.to_sentence
      redirect_back fallback_location: root_path
    end
  end

  def both_creation
    request_feedback = current_user.request_feedbacks.new(request_feedback_params)
    give_feedback = current_user.give_feedbacks.new(request_feedback_params)
    
    if request_feedback.save && give_feedback.save
      redirect_to(root_path, notice: "Request has been sent")
    else
      flash[:alert] = request_feedback.errors.full_messages.to_sentence
      redirect_back fallback_location: root_path
    end
  end

  def destroy
    fetch_request.destroy!
    redirect_to current_user, notice: "Vacation has been deleted."
  end

  private

  def request_feedback_params
    params.require(:request_feedback).permit(:feedback_type, :recipient)
  end

  def fetch_request
    current_user.request_feedbacks.find(params[:id])
  end
end
