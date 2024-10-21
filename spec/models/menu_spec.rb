require 'rails_helper'

RSpec.describe Menu, type: :model do
  it 'is valid with valid attributes' do
    menu = Menu.new(name: 'Steak Dinner')
    expect(menu).to be_valid
  end

  it 'is not valid without a name' do
    menu = Menu.new(name: nil)
    menu.valid?
    expect(menu.errors[:name]).to include("can't be blank")
  end

  it 'can have many menu items' do
    menu = Menu.new(name: 'Steak Dinner')
    MenuItemsMenu.create(menu:, menu_item: MenuItem.create(name: 'Ribeye'), price: 25.00)
    MenuItemsMenu.create(menu:, menu_item: MenuItem.create(name: 'Filet Mignon'), price: 30.00)
    expect(menu.menu_items.size).to eq(2)
  end
end
