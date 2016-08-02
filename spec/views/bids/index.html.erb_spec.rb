require 'rails_helper'

RSpec.describe "bids/index", type: :view do
  before(:each) do
    assign(:bids, [
      Bid.create!(
        :bid_price => 2,
        :auction => nil
      ),
      Bid.create!(
        :bid_price => 2,
        :auction => nil
      )
    ])
  end

  it "renders a list of bids" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
