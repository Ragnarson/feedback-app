module FeedbackHelper
  def user_feedbacks(received_offers, request_feedbacks)
    feedback_list = []

    received_offers.each do |offer|
      received_list = {}
      received_list["name"] = offer.user.name
      received_list["feedback_type"] = offer.feedback_type
      feedback_list << received_list
    end

    request_feedbacks.each do |request|
      request_list = {}
      request_list["name"] = User.find(request.recipient).name
      request_list["feedback_type"] = request.feedback_type
      feedback_list << request_list
    end

    feedback_list
  end
end