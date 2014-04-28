class FriendCirclesController < ApplicationController
  before_action :ensure_logged_in

  def index
    @friend_circles = FriendCircle.where(owner_id: params[:user_id])
  end

  def show
    @friend_circle = FriendCircle.find(params[:id])
  end

  def new
    @friend_circle = FriendCircle.new
    # @users = User.where.not(id: params[:user_id])
  end

  def create
    #change later to current user
    @friend_circle = FriendCircle.new(circle_params)
    @friend_circle.owner_id = params[:user_id]

    if @friend_circle.save
      redirect_to friend_circle_url(@friend_circle)
    else
      flash.now[:errors] = @friend_circle.errors.full_messages
      render :new
    end
  end

  private

  def circle_params
    params.require(:friend_circle).permit(:name, :member_ids => [])
  end
end
