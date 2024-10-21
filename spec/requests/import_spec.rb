require 'rails_helper'

RSpec.describe 'Imports', type: :request do
  describe 'POST /create' do
    context 'with valid data' do
      let(:file) { fixture_file_upload('two_restaurants.json', 'application/json') }

      it 'returns success status' do
        post '/import', params: { file: }
        expect(response).to have_http_status(200)
      end

      it 'creates two restaurants' do
        expect { post '/import', params: { file: } }.to change(Restaurant, :count).by(2)
      end

      it 'creates five menus' do
        expect { post '/import', params: { file: } }.to change(Menu, :count).by(5)
      end

      it 'creates 10 menu items' do
        expect { post '/import', params: { file: } }.to change(MenuItem, :count).by(10)
      end

      it 'creates 10 menu items menus' do
        expect { post '/import', params: { file: } }.to change(MenuItemsMenu, :count).by(10)
      end
    end

    context 'with repeated data' do
      let(:file) { fixture_file_upload('repeated_menu_items.json', 'application/json') }

      it 'creates two restaurants' do
        expect { post '/import', params: { file: } }.to change(Restaurant, :count).by(2)
      end

      it 'creates two menus' do
        expect { post '/import', params: { file: } }.to change(Menu, :count).by(2)
      end

      it 'creates one menu item' do
        expect { post '/import', params: { file: } }.to change(MenuItem, :count).by(1)
      end

      it 'creates two menu items menus' do
        expect { post '/import', params: { file: } }.to change(MenuItemsMenu, :count).by(2)
      end
    end

    context 'with duplicated data' do
      let(:file) { fixture_file_upload('duplicated_menu_items.json', 'application/json') }

      it 'creates one menu items menu' do
        expect { post '/import', params: { file: } }.to change(MenuItemsMenu, :count).by(1)
      end
    end

    context 'with invalid data' do
      let(:file) { fixture_file_upload('invalid_menu_items.json', 'application/json') }

      it 'returns error message' do
        expect { post '/import', params: { file: } }.to_not change(MenuItemsMenu, :count)
      end
    end
  end
end
