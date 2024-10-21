class ImportController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    file = params[:file]
    if file && file.content_type == 'application/json'
      data = JSON.parse(file.read)

      process_restaurants(data['restaurants'])

      render json: { status: 'success' }
    else
      render json: { status: 'error', message: 'Invalid file' }
    end
  rescue JSON::ParserError
    render json: { status: 'error', message: 'Invalid JSON' }
  end

  private

  def process_restaurants(restaurants)
    restaurants.each do |r|
      restaurant = Restaurant.find_or_create_by(name: r['name'])
      menus = r['menus']
      menus.each do |m|
        menu = restaurant.menus.find_or_create_by(name: m['name'])

        menu_items = m['menu_items'] || m['dishes']
        next unless menu_items

        menu_items.each do |mi|
          menu_item = MenuItem.find_or_create_by(name: mi['name'])
          menu_item_menu = menu.menu_items_menus.find_by(menu_item:) || menu.menu_items_menus.create(menu_item:)
          menu_item_menu.update(price: mi['price'])
        end
      end
    end
  end
end
