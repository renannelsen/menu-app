class MenuItemsController < ApplicationController
  def index
    menu_items = MenuItem.all
    render json: menu_items.as_json(only: [:name])
  end
end
