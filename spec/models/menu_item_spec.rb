require 'rails_helper'

RSpec.describe MenuItem, type: :model do
  it 'is valid with valid attributes' do
    menu = MenuItem.new(name: 'Burger')
    expect(menu).to be_valid
  end

  it 'is not valid without a name' do
    menu = MenuItem.new(name: nil)
    menu.valid?
    expect(menu.errors[:name]).to include("can't be blank")
  end
end
