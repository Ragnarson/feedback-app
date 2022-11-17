class User < ApplicationRecord
  establish_connection(:external_database)
  self.table_name = 'AgencyKit_production.users'

  has_many :request_feedbacks
  has_many :give_feedbacks
  has_many :recieved_offers, class_name: "GiveFeedback", foreign_key: :recipient
  has_many :feedback_requests, class_name: "RequestFeedback", foreign_key: :recipient
  has_many :give_feedbacks_status_accepted_or_happened, -> { status_accepted_or_happened }, class_name: "GiveFeedback"
  has_many :request_feedbacks_status_accepted_or_happened, -> { status_accepted_or_happened }, class_name: "RequestFeedback"
  has_many :recieved_offers_status_accepted_or_happened, -> { status_accepted_or_happened }, class_name: "GiveFeedback", foreign_key: :recipient
  has_many :feedback_requests_status_accepted_or_happened, -> { status_accepted_or_happened }, class_name: "RequestFeedback", foreign_key: :recipient

  def self.find_or_create_from_auth(auth:)
    name = auth[:info][:name]
    email = auth[:info][:email]

    create_with(name: name, email: email)
      .find_or_create_by!(provider: auth[:provider], uid: auth[:uid].to_s).tap do |user|
      user.update(auth_info: auth)
    end
  end
end
