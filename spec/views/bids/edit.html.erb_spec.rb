require 'rails_helper'

RSpec.describe "bids/edit", type: :view do
  before(:each) do
    @bid = assign(:bid, Bid.create!(
      :bid_price => 1,
      :auction => nil
    ))
  end

  it "renders the edit bid form" do
    render

    assert_select "form[action=?][method=?]", bid_path(@bid), "post" do

      assert_select "input#bid_bid_price[name=?]", "bid[bid_price]"

      assert_select "input#bid_auction_id[name=?]", "bid[auction_id]"
    end
  end
end
