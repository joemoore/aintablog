class ArticlesController < PostsController
  caches_page :mta

  def post_type
    :articles
  end

  def mta
    last_modified = post_repo.last_modified

    if fresh_when \
      :etag => (post_repo.etag || 'empty'),
      :last_modified => last_modified ? last_modified.utc : nil
      return
    end

    #@posts = post_repo.paginate_index({:all, :conditions => "content LIKE '%MTA%'", :order => "updated_ at DESC", :page => params[:page]})
    @posts = post_repo.all(:conditions => "content LIKE '%MTA%'", :order => "updated_at DESC", :include => [:comments, :feed]).paginate(:page => params[:page])
    #@posts = post_repo.all(:conditions => "content LIKE '%MTA%'", :order => "updated_at DESC", :include => [:comments, :feed])

    respond_to do |format|
      format.html { render :template => 'posts/index.html.erb' }
      format.rss  { render :template => 'posts/index.rss.builder' }
      format.xml  { render :xml => @posts }
    end
  end
end
