module FeedbackHelper
  def user_feedbacks(received_offers, request_feedbacks)
    [user_received_offers(received_offers), user_request_feedbacks(request_feedbacks)].compact_blank
  end

  def user_received_offers(received_offers)
    received_list = {}

    received_offers.each do |offer|
      received_list["name"] = offer.user.name
      received_list["feedback_type"] = offer.feedback_type
    end
    received_list
  end

  def user_request_feedbacks(request_feedbacks)
    request_list = {}

    request_feedbacks.each do |request|
      request_list["name"] = User.find(request.recipient).name
      request_list["feedback_type"] = request.feedback_type
    end
    request_list
  end

  def feedback_count(offers, requests)
    return "0" if offers.empty? && requests.empty?
    offers.count + requests.count
  end
end