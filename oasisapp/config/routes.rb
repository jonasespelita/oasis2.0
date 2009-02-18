ActionController::Routing::Routes.draw do |map|
  map.resources :grades
  map.resources :queries
  map.resources :users
  map.root :controller=> 'sessions', :action => 'new'
  map.change_photo 'change_photo', :action => 'change_photo', :controller => 'followers'
  map.upload_photo '/upload', :action => 'upload_photo', :controller => 'followers'
  map.faq '/faqs', :controller => 'static', :action => 'faq'
  map.sitemap '/sitemap', :controller => 'static', :action => "sitemap"
  map.about '/aboutus', :controller => 'static', :action =>'about'
  map.contact '/contactus', :controller => 'static', :action => 'contactus'
  map.pri '/privacy', :controller => 'static', :action => 'privacy'
  map.toc '/terms', :controller =>'static', :action => 'tos'
  map.resource :session
  map.reset_password '/reset_password',:controller =>'users', :action => 'reset_password'
  map.change_password '/change_password', :controller => 'users', :action => 'change_password'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.signup '/signup', :controller => "users", :action => "new"
  map.add_ward  'follow', :controller => "followers", :action =>"new"
  map.wards 'wards', :controller => "oasis", :action => "index"
  
  
  map.set_lang 'set_language', :controller => 'sessions', :action => 'set_language'
  map.createquery 'create_query', :controller=>"help", :action =>"create_query"
  map.query 'contact', :controller=>'help', :action => 'show_query'
  map.pref_help '/help', :controller => "help", :action =>'pref_help'
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.simple_captcha '/simple_captcha/:action', :controller => 'simple_captcha'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
