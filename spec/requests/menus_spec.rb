require 'rails_helper'

RSpec.describe 'Menus', type: :request do
  describe 'GET /index' do
    before do
      Menu.create(name: 'BBQ Ribs')
      Menu.create(name: 'Roast Duck')
      get '/menus'
    end

    it 'returns success status' do
      expect(response).to have_http_status(200)
    end

    it 'returns correct menu count' do
      expect(JSON.parse(response.body).size).to eq(2)
    end

    it 'returns correct menu names' do
      expect(JSON.parse(response.body).first['name']).to eq('BBQ Ribs')
      expect(JSON.parse(response.body).second['name']).to eq('Roast Duck')
    end
  end
end
