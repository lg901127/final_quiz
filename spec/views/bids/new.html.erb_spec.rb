require 'rails_helper'

RSpec.describe "bids/new", type: :view do
  before(:each) do
    assign(:bid, Bid.new(
      :bid_price => 1,
      :auction => nil
    ))
  end

  it "renders new bid form" do
    render

    assert_select "form[action=?][method=?]", bids_path, "post" do

      assert_select "input#bid_bid_price[name=?]", "bid[bid_price]"

      assert_select "input#bid_auction_id[name=?]", "bid[auction_id]"
    end
  end
end
