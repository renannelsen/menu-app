class RestaurantsController < ApplicationController
  def index
    restaurants = Restaurant.all
    render json: restaurants.as_json(only: %i[id name])
  end

  def show
    restaurant = Restaurant.find(params[:id])

    render json: restaurant_menus(restaurant)
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Restaurant not found' }, status: 404
  end

  private

  def restaurant_menus(restaurant)
    menus = restaurant.menus.map do |m|
      menu_items = m.menu_items.map do |mi|
        { id: mi.id, name: mi.name, price: mi.price_for_menu(m) }
      end

      { id: m.id, name: m.name, menu_items: }
    end

    { id: restaurant.id, name: restaurant.name, menus: }
  end
end
