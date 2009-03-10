class PostsController < ApplicationController
  
  def self.for_type(name)
    define_method(:post_type) { name }
  end

  # Used by feeds_controller to calculate cache expirations.
  @@subtypes = [:articles, :external_articles, :links, :pictures, :quotes, :snippets, :tweets, :gists]
  cattr_reader :subtypes 
  
  before_filter :redirect_to_admin, :if => :logged_in?
  
  caches_page :index
  caches_page :show
  
  # GET /posts
  # GET /posts.xml
  def index
    if fresh_when \
      :etag => (post_repo.etag || 'empty'),
      :last_modified => post_repo.last_modified.try(:utc)
      return
    end
    
    @posts = post_repo.paginate_index(:page => params[:page])
    
    respond_to do |format|
      format.html { render :template => 'posts/index.html.erb' }
      format.rss  { render :template => 'posts/index.rss.builder' }
      format.xml  { render :xml => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    redirect_to root_path and return unless current_post.type.match(/Article|Snippet/)
    
    if fresh_when(:etag => current_post.updated_at.to_s.hash, :last_modified => current_post.updated_at.utc)
      return
    end
    
    @comment = flash[:comment] || current_post.comments.build
    respond_to do |format|
      format.html { render :template => 'posts/show.html.erb' }
      format.xml  { render :xml => current_post }
    end
  end
  
  private
  
  def current_post
    @post ||= Post.find_by_permalink(params[:id], :include => :comments) || Post.find(params[:id])
  end
  
  def post_type
    :posts
  end
  
  def redirect_to_admin
    redirect_to admin_root_path + request.path
  end
end
