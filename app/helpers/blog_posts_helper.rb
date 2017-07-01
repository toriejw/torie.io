module BlogPostsHelper

  def format_date(date)
    return if date.nil?
    date.strftime("%B%e, %Y")
  end

end
