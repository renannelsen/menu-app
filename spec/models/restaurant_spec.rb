require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  it 'is valid with valid attributes' do
    restaurant = Restaurant.new(name: 'Super Place')
    expect(restaurant).to be_valid
  end

  it 'is not valid without a name' do
    restaurant = Restaurant.new(name: nil)
    restaurant.valid?
    expect(restaurant.errors[:name]).to include("can't be blank")
  end

  it 'is not valid with a duplicate name' do
    Restaurant.create!(name: 'Unique Place')
    duplicate_restaurant = Restaurant.new(name: 'Unique Place')
    duplicate_restaurant.valid?
    expect(duplicate_restaurant.errors[:name]).to include('has already been taken')
  end
end
