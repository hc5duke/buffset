Buffset::Application.routes.draw do
  match "/signin" => "services#signin"
  match "/signout" => "services#signout"

  match '/auth/:service/callback' => 'services#create'
  match '/auth/failure' => 'services#failure'

  resources :services, :only => [:index, :create, :destroy] do
    collection do
      get 'signin'
      get 'signout'
      get 'signup'
      post 'newaccount'
      get 'failure'
    end
  end

  resources :users, :only => [:index, :show, :edit, :update]

  namespace :admin do
    resources :users, :only => [:index, :update]
  end

  root :to => "services#signin"
end
