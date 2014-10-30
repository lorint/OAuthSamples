AndrewIG::Application.routes.draw do

  get "facebook/facebook"
  get "facebook/posts"
  get '/' => 'home#index', as: :root
  get '/instagram' => 'instagram#instagram'
  get '/instagram/feed' => 'instagram#feed', as: :feed
  post '/instagram/search' => 'instagram#search', as: :search

  get '/sc1' => 'soundcloud#sc1', as: :sc1
  get '/soundcloud' => 'soundcloud#soundcloud'

  get '/github' => 'github#github'
  get '/github/repos' => 'github#repos', as: :repos

  # Or trade this out with the facebook action
  # Used to go to the koala path
  get '/facebook' => 'facebook#facebook', as: :facebook
  get '/facebook/posts' => 'facebook#posts', as: :posts
  get '/facebook/log_out' => 'facebook#log_out', as: :fb_logout

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
