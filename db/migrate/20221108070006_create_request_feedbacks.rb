class CreateRequestFeedbacks < ActiveRecord::Migration[7.0]
  def change
    create_table :request_feedbacks do |t|
      t.integer :user_id
      t.integer :recipient
      t.integer :status, default: 0
      
      t.timestamps
    end
  end
end
