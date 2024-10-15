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
end
