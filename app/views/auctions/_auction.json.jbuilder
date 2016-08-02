json.extract! auction, :id, :title, :details, :ends_on, :reserve_price, :created_at, :updated_at
json.url auction_url(auction, format: :json)