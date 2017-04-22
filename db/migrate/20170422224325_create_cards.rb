class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
      t.string :token
      t.string :last_4
      t.integer :customer_id

      t.timestamps
    end
  end
end
