require 'rails_helper'

RSpec.describe 'MenuItems', type: :request do
  describe 'GET /index' do
    before do
      MenuItem.create(name: 'Burger')
      MenuItem.create(name: 'Fries')
    end

    it 'returns all menu items' do
      get '/menu_items'
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end
end
