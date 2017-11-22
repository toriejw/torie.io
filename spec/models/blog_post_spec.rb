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
       This would make a great
       poem.
       And one more sentence
       for good measure.}
  }

  it "sets the slug on save" do
    expect(subject.slug).to eq nil

    subject.save!

    expect(subject.slug).to eq "post-title"
  end

  describe "#set_slug" do
    context "title contains '.'" do
      subject {
        BlogPost.new(title: "Post vs. Title",
                     body: post_body)
      }

      it "removes the '.'" do
        subject.set_slug

        expect(subject.slug).to eq "post-vs-title"
      end
    end
  end

  describe "#preview" do
    it "returns an abbreviated version of the post body" do
      expect(subject.preview.split("\n").count).to eq 6
    end
  end

end
