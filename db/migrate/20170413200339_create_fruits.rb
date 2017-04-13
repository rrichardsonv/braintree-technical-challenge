class CreateFruits < ActiveRecord::Migration[5.0]
  def change
    create_table :fruits do |t|
      t.string :name
      t.float :price_per_lb
      t.text :description
      t.string :display_url

      t.timestamps
    end
  end
end
