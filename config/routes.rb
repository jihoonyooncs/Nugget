Rails.application.routes.draw do
  resources :comments
  resources :image_posts
  resources :text_posts
  resources :posts
  resources :sessions

  resources :posts do
    member do
      put "like" => "posts#upvote"
      put "unlike" => "posts#downvote"
    end
  end
  
  resources :users do
    member do
      get :friends
    end
  end

  get 'tags/:tag', to: 'posts#index', as: :tag
  get 'signup', to: 'users#new', as: 'signup'
  post 'follow/:id', to: 'users#follow', as: 'follow_user'
  get 'login', to: 'sessions#new', as: 'login'
  delete 'logout', to: 'sessions#destroy', as: 'logout'
  get 'subindex', to: 'posts#subindex', as: 'subindex'
  get 'topindex', to: 'posts#topindex', as: 'topindex'
  get 'frindex', to: 'posts#frindex', as: 'frindex'
  get 'friends', to: 'friendships#index', as: 'friends'
  post 'friends/create/:id', to: 'friendships#create', as: 'add_friend'
  put 'friends/accept.:id', to: 'friendships#accept', as: 'accept_request'
  delete 'friends/deny/:id', to: 'friendships#deny', as: 'deny_request'
  delete 'friends/delete/:id', to: 'friendships#destroy', as: 'delete_friend'
  

  root to: "posts#index"

  #get 'friendslist', to: 'users#friendslist', as: 'friendslist'


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

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
