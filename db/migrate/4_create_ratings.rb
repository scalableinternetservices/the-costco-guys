class CreateRatings < ActiveRecord::Migration[7.1]
  def change
    create_table :ratings do |t|
      t.integer :score
      t.references :user, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.text :comment

      t.timestamps
    end
  end
end
