class Notice < ActiveRecord::Base
  belongs_to :user

  def display_body
  	if(self.body)
      options = [:hard_wrap, :filter_html, :autolink, :no_intraemphasis, :fenced_code, :gh_blockcode]
      Redcarpet.new(self.body, *options).to_html.html_safe
    else
      return ""
    end
  end

  def self.user_notices(user_id)
    if user_id
      self.find_by_sql("SELECT * FROM notices
                        WHERE user_id = " + user_id.to_s + "
                        OR author_id = " + user_id.to_s + "
                        ORDER BY notices.created_at desc")
    else
      self.user.notices
    end
  end

end
