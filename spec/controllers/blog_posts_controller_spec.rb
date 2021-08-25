require "rails_helper"

describe BlogPostsController do

  context "#show" do
    subject { get :show, params: { slug: post.slug } }

    let(:post) { BlogPost.create(title: "Title", body: "Body") }

    it "renders the blog page" do
      expect(subject).to render_template(:show)
    end

    it "logs a page view" do
      expect { subject }.to change { PageView.count }.by 1

      expect(PageView.last.page).to eq "Blog #{post.slug}"
    end
  end

end
