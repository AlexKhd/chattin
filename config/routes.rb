Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], as: :finish_signup

  get 'chat', to: 'chats#chat'

  post '/checkname', to: 'users#checkname'
  # get "users/:id", to: "profiles#show", as: "profile"
  resources :profiles, only: [:show, :edit]
  resources :users, :chats, :photos

  resources :posts do
    member do
      post 'upvote', to: "posts#upvote"
      post 'downvote', to: "posts#downvote"
    end
  end

  resources :comments do
    get 'upvote'
    get 'downvote'
  end

  resources :comments, only: [:show, :edit, :update]

  resources :chats

  get 'slideshow', to: 'posts#slider'

  resources :posts do
    resources :comments, only: [:index, :new, :create, :destroy]
  end

  get 'photo/index'

  get 'dashboard/index'

  root to: 'dashboard#index'

  namespace :admin do
    resources :profiles, only: [:index]
    resources :postmans
    post 'sender/:id', to: 'postmans#sender', as: 'sender'
  end

  post 'contact_send', to: 'store#contact_send'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
