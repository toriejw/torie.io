require "rails_helper"

describe PageView do

  it "requires a page" do
    expect {
      PageView.create!
    }.to raise_error ActiveRecord::RecordInvalid

    expect {
      PageView.create!(page: "Contact")
    }.to_not raise_error
  end

  describe ".track" do
    it "saves a record of the type provided" do
      expect {
        PageView.track("Home")
      }.to change { PageView.count }.by 1

      expect(PageView.last.page).to eq "Home"
    end
  end

end
