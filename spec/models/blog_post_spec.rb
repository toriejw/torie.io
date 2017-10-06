require "rails_helper"

describe BlogPost do

  subject {
    BlogPost.new(title: "Post Title",
                 body: post_body)
  }

  let(:post_body) {
    %Q{This is the body of a post
       with multiple lines.

       Here's another sentence.
       And one more for good
       measure.}
  }

  it "sets the slug on save" do
    expect(subject.slug).to eq nil

    subject.save!

    expect(subject.slug).to eq "post-title"
  end

  context "#preview" do
    it "returns an abbreviated version of the post body" do
      expect(subject.preview.split("\n").count).to eq 4
    end
  end

end
