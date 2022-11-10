class RequestFeedback < ApplicationRecord
  belongs_to :user

  validates :feedback_type, presence: true
  validate :offer_exist

  AVAILABLE_TYPES = ["Note", "Group meeting", "1-on-1"].freeze

  enum :status, { pending: 0, accepted: 1, declined: 2, happened: 3 }, suffix: true

  def self.feedback_types
    AVAILABLE_TYPES
  end

  private

  def offer_exist
    if GiveFeedback.find_by(recipient: self.user.id, feedback_type: self.feedback_type).present?
      self.errors.add(:you_have_already_received_feedback_offer, "from #{User.find_by(id: self.recipient).name}")
    end
  end
end
