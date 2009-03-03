<h3 class="entry-title"><%= spanned_link post.header, post.link %></h3>

<%= render :partial => 'posts/date', :locals => {:post => post}%>

<div class="entry entry-content external-article ">
<% cache(post.permalink) do -%>
  <%#image_tag("external_article.png", :class => 'icon', :width => 36, :height => 36) + clean_content_for(post) %>
  <%= clean_content_for(post) %>
<% end -%>
</div>

<% if params[:action] == 'index' -%>

  <div class="meta">
    <% if logged_in? -%>
    <%= link_to 'Edit', edit_article_path(post) unless post.from_feed? %>
    <%= link_to 'Destroy', admin_post_path(post), :method => :delete, :confirm => "Click OK to delete this post forever." %>
    <% end %>
  </div>

  <% if post.from_feed? -%>
  <cite>&#x2010; Posted via <%= link_to post.feed.title, post.feed.url %></cite>
  <% end -%>

<% else -%>

<%= render :partial => "/posts/types/comments.html.erb" if post.allow_comments? %>

<small><%= link_to 'Click here to go home', root_path %></small>

<% end -%>
