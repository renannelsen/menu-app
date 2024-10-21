class CreateMenuItemsMenusJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_table :menu_items_menus, id: false do |t|
      t.references :menu, null: false, foreign_key: true, index: true
      t.references :menu_item, null: false, foreign_key: true, index: true
      t.decimal :price, precision: 5, scale: 2, null: false
      t.timestamps
    end

    add_index :menu_items_menus, %i[menu_id menu_item_id], unique: true
  end
end
