class RequestFeedback < ApplicationRecord
  belongs_to :user

  validates :feedback_type, presence: true

  AVAILABLE_TYPES = ["Note", "Group meeting", "1-on-1"].freeze

  enum :status, { pending: 0, accepted: 1, declined: 2, happened: 3 }, suffix: true

  def self.feedback_types
    AVAILABLE_TYPES
  end
end
