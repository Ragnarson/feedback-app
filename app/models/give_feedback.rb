class GiveFeedback < ApplicationRecord
  belongs_to :user

  validates :feedback_type, presence: true
  validate :request_exist

  AVAILABLE_TYPES = ["Note", "Group meeting", "1-on-1"].freeze

  enum :status, { pending: 0, accepted: 1, declined: 2, happened: 3 }, suffix: true

  scope :status_accepted_or_happened, -> { where(status: :accepted).or(where(status: :happened)) }
  scope :status_pending, -> { where(status: :pending) }

  def self.feedback_types
    AVAILABLE_TYPES
  end

  private

  def request_exist
    if RequestFeedback.find_by(recipient: self.user.id).present?
      self.errors.add(:you_have_already_received_request_for_feedback, "from #{User.find_by(id: self.recipient).name}")
    end
  end
end
