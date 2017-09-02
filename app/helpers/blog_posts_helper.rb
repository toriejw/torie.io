module BlogPostsHelper

  def format_date(date)
    return if date.nil?
    date.strftime("%B %-d, %Y")
  end

end
