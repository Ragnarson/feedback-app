class User < ApplicationRecord
  has_many :request_feedbacks #to gdzie zlozylismy prosbe
  has_many :give_feedbacks #to gdzie my zlozylismy oferte

  # to gdzie dostalismy oferte feedbacku od kogos
  has_many :recieved_offers, class_name: "GiveFeedback", foreign_key: :recipient
  has_many :feedback_requests, class_name: "RequestFeedback", foreign_key: :recipient

  def self.find_or_create_from_auth(auth:)
    name = auth[:info][:name]
    email = auth[:info][:email]

    create_with(name: name, email: email)
      .find_or_create_by!(provider: auth[:provider], uid: auth[:uid].to_s).tap do |user|
      user.update(auth_info: auth)
    end
  end
end
