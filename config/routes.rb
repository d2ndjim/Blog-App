Rails.application.routes.draw do
  devise_for :users,
             controllers: {
                 sessions: 'users/sessions',
                 registrations: 'users/registrations'
              }
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end
  root 'users#index'
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create]
  end

  resources :posts, only: [:new, :create, :update, :destroy] do
    resources :comments
    resources :likes
  end

  get 'api/users/:id/posts' => 'users#api_show', format: 'json'
  get 'api/users/:id/posts/:id/comments' => 'posts#api_show', format: 'json'
  post 'api/users/:id/posts/:id/comments' => 'posts#api_create'
end
