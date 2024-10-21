class ImportController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    file = params[:file]
    if file && file.content_type == 'application/json'
      data = JSON.parse(file.read)

      response_log = process_restaurants(data)

      if response_log.nil?
        render json: { status: 'fail', message: 'Invalid JSON' }, status: 400
        return
      end

      render json: response_log, status: 200
    else
      render json: { status: 'fail', message: 'Invalid file' }, status: 400
    end
  rescue JSON::ParserError
    render json: { status: 'fail', message: 'Invalid JSON' }, status: 400
  end

  private

  def process_restaurants(data)
    return unless data['restaurants']

    restaurants_log = []
    restaurants = data['restaurants']
    restaurants.each do |r|
      next unless r['name']

      restaurant = Restaurant.find_or_create_by(name: r['name'])

      menus_log = []
      menus = r['menus']
      menus.each do |m|
        next unless m['name']

        menu = restaurant.menus.find_or_create_by(name: m['name'])

        menu_items_log = []
        menu_items = m['menu_items'] || m['dishes']
        next unless menu_items

        menu_items.each do |mi|
          if mi['name'].nil? || mi['price'].nil?
            menu_items_log << { name: mi['name'], price: mi['price'], status: 'fail' }
            next
          end

          menu_item_log = {
            name: mi['name'],
            price: mi['price']
          }

          menu_item = MenuItem.find_or_create_by(name: mi['name'])
          menu_item_menu = menu.menu_items_menus.find_by(menu_item:) || menu.menu_items_menus.create(menu_item:)

          if menu_item_menu.price.nil? || menu_item_menu.price != mi['price']
            menu_item_log[:status] = 'sucess'
            menu_item_log[:old_price] = menu_item_menu.price
            menu_item_menu.update(price: mi['price'])
          else
            menu_item_log[:status] = 'fail'
          end

          menu_items_log << menu_item_log
        end

        menus_log << { name: m['name'], menu_items: menu_items_log }
      end

      restaurants_log << { name: r['name'], menus: menus_log }
    end

    { restaurants: restaurants_log }
  end
end
