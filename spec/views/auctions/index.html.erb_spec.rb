require 'rails_helper'

RSpec.describe "auctions/index", type: :view do
  before(:each) do
    assign(:auctions, [
      Auction.create!(
        :title => "Title",
        :details => "MyText",
        :reserve_price => 2
      ),
      Auction.create!(
        :title => "Title",
        :details => "MyText",
        :reserve_price => 2
      )
    ])
  end

  it "renders a list of auctions" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
