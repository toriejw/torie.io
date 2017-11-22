require "rails_helper"

describe PagesController do

  describe "#home" do
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

  describe "#contact" do
    subject { get :contact }

    it "renders the contact page" do
      expect(subject).to render_template(:contact)
    end

    it "logs a page view" do
      expect { subject }.to change { PageView.count }.by 1

      expect(PageView.last.page).to eq "Contact"
    end
  end

  describe "#blog" do
    subject { get :blog }

    it "renders the home page" do
      expect(subject).to render_template(:blog)
    end

    it "logs a page view" do
      expect { subject }.to change { PageView.count }.by 1

      expect(PageView.last.page).to eq "Blog"
    end
  end

end
