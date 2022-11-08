class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :email
      t.jsonb :auth_info    
      t.index [:provider, :uid], unique: true

      t.timestamps
    end
  end
end
