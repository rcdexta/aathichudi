Aathichudi::Application.routes.draw do
  devise_for :users

  get 'admin/dashboard' => 'admin#index', :as => 'admin_dashboard'

  resources :wikis, :only => [:show, :edit, :update]

  root :to => "home#index"

end
