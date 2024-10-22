require 'rails_helper'

RSpec.describe 'Restaurants', type: :request do
  describe 'GET /index' do
    before do
      restaurant = Restaurant.create!(name: 'Super Place')
      menu = restaurant.menus.create!(name: 'BBQ Ribs')
      menu_item = MenuItem.create!(name: 'Ribs')
      menu.menu_items_menus.create!(menu_item:, price: 10.0)
      get '/restaurants'
    end

    it 'returns success status' do
      expect(response).to have_http_status(200)
    end

    it 'returns correct restaurant count' do
      expect(JSON.parse(response.body).size).to eq(1)
    end

    it 'returns correct restaurant name' do
      expect(JSON.parse(response.body).first['name']).to eq('Super Place')
    end
  end

  describe 'GET /show' do
    before do
      restaurant = Restaurant.create!(name: 'Super Place')
      menu = restaurant.menus.create!(name: 'BBQ Ribs')
      menu_item = MenuItem.create!(name: 'Ribs')
      menu.menu_items_menus.create!(menu_item:, price: 10.0)
      get "/restaurants/#{restaurant.id}"
    end

    it 'returns success status' do
      expect(response).to have_http_status(200)
    end

    it 'returns correct restaurant name' do
      expect(JSON.parse(response.body)['name']).to eq('Super Place')
    end

    it 'returns correct menu count' do
      expect(JSON.parse(response.body)['menus'].size).to eq(1)
    end

    it 'returns correct menu name' do
      expect(JSON.parse(response.body)['menus'].first['name']).to eq('BBQ Ribs')
    end

    it 'returns correct menu item count' do
      expect(JSON.parse(response.body)['menus'].first['menu_items'].size).to eq(1)
    end

    it 'returns correct menu item name' do
      expect(JSON.parse(response.body)['menus'].first['menu_items'].first['name']).to eq('Ribs')
    end

    it 'returns correct menu item price' do
      expect(JSON.parse(response.body)['menus'].first['menu_items'].first['price']).to eq('10.0')
    end
  end
end
