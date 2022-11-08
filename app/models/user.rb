class User < ApplicationRecord
  has_many :request_feedbacks
  has_many :give_feedbacks

  def self.find_or_create_from_auth(auth:)
    name = auth[:info][:name]
    email = auth[:info][:email]

    create_with(name: name, email: email)
      .find_or_create_by!(provider: auth[:provider], uid: auth[:uid].to_s).tap do |user|
      user.update(auth_info: auth)
    end
  end
end
