Rubykaigi::Application.routes.draw do
  scope '/:year/:locale', :constraints => {:year => /2\d{3}/, :locale => /en|ja/} do
    match 'registration',
      :to => 'registrations#index',
      :as => 'registrations'
    match 'phone_registration', :to => 'registrations#phone_index'
    match 'programs' => 'programs#index'
    match 'events/:id' => 'events#show', :as => 'event'
  end

  match 'signin', :to => 'sessions#new', :as => 'signin'
  delete 'signout', :to => 'sessions#destroy', :as => 'signout'
  match 'my_tickets', :to => 'tickets#index', :as => "my_tickets"

  resource :sessions do
    collection do
      get :unauthenticated
    end
  end
  resource :account
  resources :rubyists

  resources :carts do
    collection do
      post :add_item
      delete :remove_item
    end
  end
  resources :orders do
    collection do
      get :confirm
      get :thanks
      get :returned
      get :individual_sponsor_option
    end
  end
  resources :tickets do
    member do
      put :regenerate_permalink
    end
  end

  match "/paypal/instant_payment_notification",
    :to => 'paypal#instant_payment_notification',
    :as => 'paypal_ipn'
  match 'dashboard',
    :to => 'dashboard#index',
    :as => 'dashboard'

  scope ':year', :to => 'pages#show', :defaults => {:page_name => "index"} do
    match ':locale(/:page_name)',
      :as => 'page',
      :constraints => {:year => /2\d{3}/, :locale => /en|ja/ }
    match '(/:page_name)',
      :constraints => {:year => /2\d{3}/}
  end

  root :to => 'welcome#index'

  match ':controller(/:action(/:id))'
end
