class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :place
      t.integer :quantity
      t.date :produced_at
      t.text :detail
      t.text :process
      t.integer :user_id
      t.integer :fermentation_id

      t.timestamps
    end
  end
end
