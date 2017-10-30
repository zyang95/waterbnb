Rails.application.routes.draw do

#this section to deal with routing pages

root 'listings#index'

#payment routes
get 'reservations/:id/paypal' => 'reservations#paypal', as: 'paypal_form'
post 'reservations/:id/paypal_checkout' => 'reservations#paypal_checkout', as: 'paypal_checkout'



# This section is also used to deal with user creation/logging in
# This is clearance authentication

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "clearance/users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  resources :users, only: [:edit, :update, :show]

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  get "/users/:id/listings" => "users#listings", as: "user_listings"


# end of clearance authecation
 get "/auth/:provider/callback" => "sessions#create_from_omniauth"

# superadmin routes
  get "/users/:id/super_admin" => "users#super_admin", as: "super_admin"

  get "/listings/:id/approve" => "listings#approval", as: "approve"



#routes for listing
 
resources :listings
resources :reservations, only: [:new, :index, :create, :destroy]


get "/users/:id/reservations" => "users#reservations", as: "user_reservations"

#end
  
  
end



