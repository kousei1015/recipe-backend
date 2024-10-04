Rails.application.routes.draw do
  root 'health#index'
  
  namespace :v1 do
    mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      registrations: 'v1/auth/registrations'
    }
    
    resources :users do
      # resources :recipes, only: [:index]
      get 'recipes', to: 'recipes#user_recipes', as: 'user_recipes'
      resource :relationships, only: [:index, :create, :destroy]
      
      member do
        get :followings
        get :followers
      end
      
      collection do
        get :myfollowings
        get :myfollowers
        get :current_user_info
      end
    end
    
    resources :recipes do
      collection do
        get 'all'
      end
    end
    
    resources :favorites
    resources :relationships
  end
end
