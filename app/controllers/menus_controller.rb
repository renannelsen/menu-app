class MenusController < ApplicationController
  def index
    menus = Menu.all
    render json: menus.as_json(only: [:name])
  end
end
