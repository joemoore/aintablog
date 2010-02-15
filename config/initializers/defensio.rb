module Defensio 
  module ActsAs
    module ClassMethods
  def acts_as_defensio(type, options={})
    include InstanceMethods
    
    case type
    when :article
      if options.has_key? :announce_when
        after_save :announce_article
      else
        after_create :announce_article!
      end
    when :comment
      # OVERRIDE: Swich to before_create
      before_create :audit_comment
    end
  
    @defensio_type = type
    self.defensio_options = options
    @defensio = Defensio::Client.new(@defensio_options)
  
    unless defensio_options.has_key?(:validate_key) && !defensio_options[:validate_key]
      raise Defensio::InvalidAPIKey unless @defensio.validate_key.success?
    end
  end
  
  def audit_comment
    raise Defensio::Error,
          "You have to pass the current request environement:\n\t@comment.env = request.env" unless @env
    
    article_field = self.class.defensio_fields(:article)
    raise Defensio::Error,
          "You must specify an assiociated object which acts_as_defensio_article" unless respond_to? article_field
    article = send article_field
    
    fields = { :user_ip      => @env['REMOTE_ADDR'],
               :referrer     => @env['HTTP_REFERER'],
               :article_date => convert_to_defensio_date(article.created_at),
               :comment_type => self.class.comment_type }
    
    fields.merge! extract_optional_fields_value(self, :author, :content, :title, :author_email, :author_url, :prefix => 'comment_')
    fields.merge! extract_optional_fields_value(self, :user_logged_in, :trusted_user)
    fields.merge! extract_optional_fields_value(article, :permalink)

    response = nil
    log_and_ignore_error do
      response = self.class.defensio.audit_comment fields
    end
    
    if response
      raise Defensio::Error, response.message unless response.success?
      self.signature = response.signature
      self.spam      = response.spam
      self.spaminess = response.spaminess
      # OVERRIDE: we are evoked in a before_create now.  We do not need to save.      
      # save(false) unless self.spam
    end
  end
end
end  
end
ActiveRecord::Base.extend Defensio::ActsAs::ClassMethods