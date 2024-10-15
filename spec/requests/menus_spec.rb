require 'rails_helper'

RSpec.describe 'Menus', type: :request do
  describe 'GET /index' do
    before do
      Menu.create(name: 'BBQ Ribs')
      Menu.create(name: 'Roast Duck')
    end

    it 'returns all menus' do
      get '/menus'
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end
end
