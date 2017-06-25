require "rails_helper"

describe PagesController do

  context "#home" do
    subject { get :home }

    it "renders the home page" do
      expect(subject).to render_template(:home)
    end
  end

end
