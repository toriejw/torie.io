require "rails_helper"

describe BlogPostsController do

  context "#show" do
    subject { get :show, id: post.id }

    let(:post) { BlogPost.create(title: "Title", body: "Body") }

    it "renders the blog page" do
      expect(subject).to render_template(:show)
    end
  end

end
