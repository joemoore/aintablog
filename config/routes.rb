ActionController::Routing::Routes.draw do |map|
  map.resources :feeds, :collection => { :refresh => :post }  
  map.resources :posts
  map.resources :users
  map.resource  :session
  map.resources :articles, :has_many => :comments, :collection => {:mta => :get}
  map.mta '/mta', :controller => 'articles', :action => 'mta'
  map.resources :external_articles
  map.resources :quotes
  map.resources :pictures
  map.resources :gists
  map.resources :tweets
  map.resources :links
  map.resources :snippets, :has_many => :comments
  map.resources :comments, :member => { :report => :put }, :collection => { :spammy => :delete }
  
  map.namespace(:admin) do |admin|
    admin.root :controller => 'posts'
    admin.resources :posts
    admin.resources :articles, :has_many => :comments
    admin.resources :quotes
    admin.resources :pictures
    admin.resources :tweets
    admin.resources :links
    admin.resources :snippets, :has_many => :comments
    admin.resources :comments, :member => { :report => :put }
  end
  
  # allow for page links like "/posts/page/2"
  map.connect '/:posts_type/page/:page', :controller => 'posts'
  map.connect '/admin/:posts_type/page/:page', :controller => 'admin/posts'

  map.signup '/signup', :controller => 'users', :action => 'new'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  
  # mephisto migration
  map.mephisto_post_day '/:year/:month/:day/:id', :controller => 'posts', :action => "show"
  map.mephisto_month '/:year/:month/:id', :controller => 'posts', :action => "show"
  map.mephisto_feed 'feed', :controller => "posts", :format => 'rss'
  map.mephisto_feed_format 'feed.:format', :controller => "posts"
  map.mephisto_atom_xml 'feed/atom.xml', :controller => "posts", :format => 'rss'
  
  map.root :controller => 'posts'
end
