module ApplicationHelper

  def site_name
    # Change the value below between the quotes.
    "正心校友資訊系統"
  end
  
  def site_url
      if Rails.env.production?
        # Place your production URL in the quotes below
        "https://alumni.shsh.tw"
      else
        # Our dev & test URL
        "http://localhost:3000"
      end
  end
  
  def meta_author
      "正心中學"
  end
  
  def meta_description
      "會員資料管理"
  end
  
  def meta_keywords
     "學校 高中 國中 校友會"
  end
    
  # Returns the full title on a per-page basis.
    # No need to change any of this we set page_title and site_name elsewhere.
  def full_title(page_title)
      if page_title.empty?
        site_name
      else
        "#{page_title} | #{site_name}"
      end
  end
  
  def notifications_counts
     Notification.where(:user_id=>current_user, :read=>false).count
  end
      
  def flash_class(level)
     case level.to_sym
       when :notice then "alert alert-info"
       when :success then "alert alert-success"
       when :error then "alert alert-danger"
       when :danger then "alert alert-danger"
       when :warning then "alert alert-warning"
     end
  end

end
