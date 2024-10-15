Rails.application.routes.draw do
  resources :menus, only: [:index]
  resources :menu_items, only: [:index]
end
