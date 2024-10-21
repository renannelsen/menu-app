Rails.application.routes.draw do
  resources :import, only: [:create]
  resources :menu_items, only: [:index]
  resources :menus, only: [:index]
end
