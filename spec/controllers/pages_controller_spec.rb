require "rails_helper"

describe PagesController do

  context "#home" do
    subject { get :home }

    it "renders the home page" do
      expect(subject).to render_template(:home)
    end

    it "logs a page view" do
      expect { subject }.to change { PageView.count }.by 1

      expect(PageView.last.page).to eq "Home"
    end
  end

  describe "#about" do
    subject { get :about }

    it "renders the about page" do
      expect(subject).to render_template(:about)
    end

    it "logs a page view" do
      expect { subject }.to change { PageView.count }.by 1

      expect(PageView.last.page).to eq "About"
    end
  end

end
