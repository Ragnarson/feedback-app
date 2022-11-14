class GiveFeedback < ApplicationRecord
  belongs_to :user
  
  validates :feedback_type, presence: true
  validate :request_exist

  scope :status_accepted_or_happened, -> { where(status: :accepted).or(where(status: :happened)) }

  enum :status, { pending: 0, accepted: 1, declined: 2, happened: 3 }, suffix: true

  AVAILABLE_TYPES = ["Note", "Group meeting", "1-on-1"].freeze

  def self.feedback_types
    AVAILABLE_TYPES
  end

  private

  def request_exist
    if RequestFeedback.find_by(recipient: self.user.id, feedback_type: self.feedback_type).present?
      self.errors.add(:you_have_already_received_request_for_feedback, "from #{User.find_by(id: self.recipient).name}")
    end
  end
end
