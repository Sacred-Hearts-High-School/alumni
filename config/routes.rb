Rails.application.routes.draw do

  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get    'search'  => 'members#search'
  post   'search'  => 'members#search'

  root 'welcome#index'
  
  resources :members do
  	collection do   # 針對 members 群組進行路由
      post :import
      get :search
      post :search
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
