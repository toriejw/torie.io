class BlogPost < ActiveRecord::Base

  def preview
    body.split("\n").first(4).join("\n")
  end

end
