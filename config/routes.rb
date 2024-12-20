Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "item#index"

  get "register" => "user#register_form"
  post "register" => "user#handle_register"

  get "login" => "session#login_form"
  post "login" => "session#handle_login"
  get "logout" => "session#handle_logout"

  get "create_listing" => "item#create_listing_form"
  post "create_listing" => "item#handle_create_listing"

  get "item/:id" => "item#show_listing", as: :item
  post "item/:id/order" => "item#create_order", as: :create_order
  get "items" => "item#index", as: :items

  post "item/:id/review" => "ratings#create_rating", as: :add_review

  get "profile" => "user#show_profile"

  get "messages" => "message#index"
  get "messages/:user_id" => "message#show_messages", as: :conversation
  post "messages/:user_id" => "message#create"

  post '/items/:item_id/ratings', to: 'ratings#create_rating', as: 'create_rating'
end
