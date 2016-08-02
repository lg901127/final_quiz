class BidsController < ApplicationController
  before_action :set_bid, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :authorize_owner, only: [:edit, :destroy]
  # GET /bids
  # GET /bids.json
  def index
    @bids = Bid.all
  end

  # GET /bids/1
  # GET /bids/1.json
  def show
  end

  # GET /bids/new
  def new
    @bid = Bid.new
  end

  # GET /bids/1/edit
  def edit
  end

  # POST /bids
  # POST /bids.json
  def create
    auction = Auction.find params[:auction_id]
    if auction.user == current_user
      redirect_to root_path, notice: "WTF???"
    else
      if params["bid"]["bid_price"].to_i > Bid.where(auction_id: auction.id).order(bid_price: :desc).first.bid_price
        bid_date = Date.today
        @bid = Bid.new(bid_price: params["bid"]["bid_price"].to_i, bid_date: bid_date)
        @bid.auction = auction
        @bid.user = User.find params[:user_id]
        respond_to do |format|
          if @bid.save
            if params["bid"]["bid_price"].to_i >= auction.reserve_price
              auction.meet_reserve
              auction.save
            end
            format.html { redirect_to user_auction_path(@bid.user, @bid.auction), notice: 'Bid was successfully created.' }
            format.json { render :show, status: :created, location: @bid }
          else
            format.html { render :new }
            format.json { render json: @bid.errors, status: :unprocessable_entity }
          end
        end
      else
        redirect_to user_auction_path(current_user, auction), notice: "Bid higher!"
      end
    end
  end

  # PATCH/PUT /bids/1
  # PATCH/PUT /bids/1.json
  def update
    respond_to do |format|
      if @bid.update(bid_params)
        format.html { redirect_to @bid, notice: 'Bid was successfully updated.' }
        format.json { render :show, status: :ok, location: @bid }
      else
        format.html { render :edit }
        format.json { render json: @bid.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bids/1
  # DELETE /bids/1.json
  def destroy
    @bid.destroy
    respond_to do |format|
      format.html { redirect_to bids_url, notice: 'Bid was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bid
      @bid = Bid.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
end
