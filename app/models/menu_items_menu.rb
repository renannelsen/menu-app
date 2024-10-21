class MenuItemsMenu < ApplicationRecord
  belongs_to :menu, dependent: :destroy
  belongs_to :menu_item, dependent: :destroy

  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
