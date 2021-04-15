Rails.application.routes.draw do
  resources :publishers
  resources :book_authors
  resources :authors
  resources :books
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
