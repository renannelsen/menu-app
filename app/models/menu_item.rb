class MenuItem < ApplicationRecord
  has_many :menu_items_menus
  has_many :menus, through: :menu_items_menus

  validates :name, presence: true

  def price_for_menu(menu_id)
    menu_items_menus.find_by(menu_id:)&.price
  end
end
