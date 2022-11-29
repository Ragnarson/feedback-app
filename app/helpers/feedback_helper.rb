module FeedbackHelper
  def user_feedbacks(received_offers, request_feedbacks)
    [user_received_offers(received_offers), user_request_feedbacks(request_feedbacks)].flatten.compact_blank
  end

  def user_received_offers(received_offers)
    received_list = []

    received_offers.each do |offer|
      received_offer = {}
      received_offer["name"] = offer.user.name
      received_offer["feedback_type"] = offer.feedback_type
      received_offer["status"] = offer.status
      received_list << received_offer
    end
    received_list
  end

  def user_request_feedbacks(request_feedbacks)
    request_list = []

    request_feedbacks.each do |request|
      request_feedback = {}
      request_feedback["name"] = User.find(request.recipient).name
      request_feedback["feedback_type"] = request.feedback_type
      request_feedback["status"] = request.status
      request_list << request_feedback
    end
    request_list
  end

  def feedback_count(offers, requests)
    return "0" if offers.empty? && requests.empty?
    offers.count + requests.count
  end

  def object_details(object)
   [object["name"], "(#{object["feedback_type"]})", " - ", object["status"]].join
  end
end