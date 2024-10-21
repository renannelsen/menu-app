require 'rails_helper'

RSpec.describe 'MenuItems', type: :request do
  describe 'GET /index' do
    before do
      MenuItem.create(name: 'Burger')
      MenuItem.create(name: 'Fries')
      get '/menu_items'
    end

    it 'returns success status' do
      expect(response).to have_http_status(200)
    end

    it 'returns correct menu count' do
      expect(JSON.parse(response.body).size).to eq(2)
    end

    it 'returns correct menu names and prices' do
      expect(JSON.parse(response.body).first['name']).to eq('Burger')
      expect(JSON.parse(response.body).second['name']).to eq('Fries')
    end
  end
end
