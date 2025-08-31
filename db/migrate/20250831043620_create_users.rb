class CreateUsers < ActiveRecord::Migration[8.0]
  def up
    create_table :users do |t|
      t.string :user_id
      t.string :password_digest
      t.string :nickname
      t.string :comment

      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end
