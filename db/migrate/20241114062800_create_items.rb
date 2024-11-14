class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.integer :stock
      t.references :user, null: false, foreign_key: true
      t.float :price
      t.references :rating, null: false, foreign_key: true

      t.timestamps
    end
  end
end
