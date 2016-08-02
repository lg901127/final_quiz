Rails.application.routes.draw do
  root "home#index"
  resources :users do
    resources :auctions do
      resources :bids
    end
    get "/bids" => "users#bids"
  end

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

end
