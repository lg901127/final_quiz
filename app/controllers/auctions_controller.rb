class AuctionsController < ApplicationController
  before_action :set_auction, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :authorize_owner, only: [:edit, :destroy]
  # GET /auctions
  # GET /auctions.json
  def index
    @auctions = Auction.all
  end

  # GET /auctions/1
  # GET /auctions/1.json
  def show
    auction = Auction.find params[:id]
    bids = auction.bids.order(bid_price: :desc)
    bids_info = []
    bids.each do |bid|
      bid_info = {
        id: bid.id,
        bid_price: bid.bid_price,
        bid_date: bid.bid_date,
        user: User.find(bid.user_id).full_name
      }
      bids_info << bid_info
    end
    @bid = Bid.new
    respond_to do |format|
      format.html
      format.json { render json: bids_info}
    end
  end

  # GET /auctions/new
  def new
    @auction = Auction.new
  end

  # GET /auctions/1/edit
  def edit
  end

  # POST /auctions
  # POST /auctions.json
  def create
    @auction = Auction.new(auction_params)
    @auction.user = User.find params[:user_id]
    @auction.submit
    respond_to do |format|
      if @auction.save
        format.html { redirect_to user_auction_path(@auction.user_id, @auction), notice: 'Auction was successfully created.' }
        format.json { render :show, status: :created, location: @auction }
      else
        format.html { render :new }
        format.json { render json: @auction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /auctions/1
  # PATCH/PUT /auctions/1.json
  def update
    respond_to do |format|
      if @auction.update(auction_params)
        format.html { redirect_to user_auction_path(@auction.user_id, @auction), notice: 'Auction was successfully updated.' }
        format.json { render :show, status: :ok, location: @auction }
      else
        format.html { render :edit }
        format.json { render json: @auction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /auctions/1
  # DELETE /auctions/1.json
  def destroy
    @auction.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Auction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_auction
      @auction = Auction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def auction_params
      params.require(:auction).permit(:title, :details, :ends_on, :reserve_price)
    end
end
