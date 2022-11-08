class AddTypeToFeedbacks < ActiveRecord::Migration[7.0]
  def change
    add_column :request_feedbacks, :feedback_type, :string
    add_column :give_feedbacks, :feedback_type, :string
  end
end
