Rails.application.routes.draw do
  resources :menus, only: [:index]
end
