Rubykaigi::Application.routes.draw do
  match ":year/:locale/timetable",
    :to => 'events#timetable',
    :as => 'timetable',
    :constraints => {:year => /2\d{3}/, :locale => /en|ja/}

  scope '/:year/:locale' do
    resources :events,
      :constraints => {:year => /2\d{3}/, :locale => /en|ja/},
      :only => %w(index show)
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
  match ':year/:locale/Registration',
    :to => 'registrations#index',
    :as => 'registrations',
    :constraints => {:year => /2\d{3}/, :locale => /en|ja/}

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
