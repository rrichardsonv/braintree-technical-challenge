class CreateCustomers < ActiveRecord::Migration[5.0]
  def change
    create_table :customers do |t|
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :bt_id
      t.timestamps
    end
  end
end
