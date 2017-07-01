require "rails_helper"

describe BlogPostsHelper do
  let(:post) {
    BlogPost.create(title: "Title", body: "Body")
  }

  describe "#format_date" do
    it "formats dates correctly" do
      Timecop.freeze("2017-01-01") do
        expect(format_date(post.created_at)).to eq "January 1, 2017"
      end
    end

    context "date is nil" do
      it "returns nil" do
        expect(format_date(nil)).to eq nil
      end
    end
  end

end
