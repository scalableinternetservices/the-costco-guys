class UpdateQuantityInItems < ActiveRecord::Migration[7.1]
  def up
    # First set default value for existing records
    Item.where(quantity: nil).update_all(quantity: 0)
    
    # Then change the column to not allow null and set default
    change_column :items, :quantity, :integer, null: false, default: 0
  end

  def down
    change_column :items, :quantity, :integer, null: true, default: nil
  end
end