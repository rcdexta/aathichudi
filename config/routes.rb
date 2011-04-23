Aathichudi::Application.routes.draw do
  devise_for :users

  get 'admin/dashboard' => 'admin#index', :as => 'admin_dashboard'
  get 'admin/review/:wiki_version_id' => 'admin#edit', :as => 'admin_review_wiki'
  put 'admin/update/:wiki_version_id' => 'admin#update', :as => 'admin_update_wiki'

  resources :wikis, :only => [:show, :edit, :update]

  root :to => "home#index"

end
