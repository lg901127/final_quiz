class UsersController < ApplicationController
  def show
    @user = User.find params[:id]
  end

  def new
    @user = User.new
  end

  def create
    user_params = params.require(:user).permit(:full_name, :email, :password, :password_confirmation)
    @user = User.new user_params
    if @user.save
      sign_in(@user)
      redirect_to user_auctions_path(@user), notice: "You are now signed in!"
    else
      render :new
    end
  end

  def bids
    @user = User.find params[:user_id]
    @bids = @user.bids
  end
end
