require 'rails_helper'

RSpec.describe "auctions/show", type: :view do
  before(:each) do
    @auction = assign(:auction, Auction.create!(
      :title => "Title",
      :details => "MyText",
      :reserve_price => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/2/)
  end
end
