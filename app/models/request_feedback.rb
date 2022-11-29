class RequestFeedback < ApplicationRecord
  belongs_to :user
  
  validates :feedback_type, presence: true
  validate :offer_exist

  scope :status_accepted_or_happened, -> { where(status: :accepted).or(where(status: :happened)) }
  scope :status_happened, -> { (where(status: :happened)) }

  enum :status, { pending: 0, accepted: 1, declined: 2, happened: 3 }, suffix: true
  
  AVAILABLE_TYPES = ["Note", "Group meeting", "1-on-1"].freeze

  def self.feedback_types
    AVAILABLE_TYPES
  end

  private

  def offer_exist
    if GiveFeedback.find_by(user_id: self.recipient, recipient: self.user.id, feedback_type: self.feedback_type).present?
      self.errors.add(:you_have_already_received_feedback_offer, "from #{User.find_by(id: self.recipient).name}")
    end
  end
end
