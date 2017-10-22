Rails.application.routes.draw do

#this section to deal with routing pages

root 'welcome#index'

#end of section routing



# This section is also used to deal with user creation/logging in
# This is clearance authentication

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "clearance/users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  resources :users, only: [:edit, :update]

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"

# end of clearance authecation
 get "/auth/:provider/callback" => "sessions#create_from_omniauth"

# end of usercreation/authentication


#routes for listing
 
 resources :listings
 resources :reservations

#end
  
  
end



