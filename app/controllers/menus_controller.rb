class MenusController < ApplicationController
  def index
    menus = Menu.all
    render json: menus.as_json(only: %i[id name])
  end
end
