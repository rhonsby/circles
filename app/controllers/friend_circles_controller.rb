class FriendCirclesController < ApplicationController
  before_action :ensure_logged_in

  def index
    @friend_circles = FriendCircle.where(owner_id: current_user.id)
  end

  def show
    @friend_circle = FriendCircle.find(params[:id])
  end

  def new
    @friend_circle = FriendCircle.new
  end

  def create
    @friend_circle = FriendCircle.new(circle_params)
    @friend_circle.owner_id = current_user.id

    if @friend_circle.save
      redirect_to friend_circle_url(@friend_circle)
    else
      flash.now[:errors] = @friend_circle.errors.full_messages
      render :new
    end
  end

  def edit
    @friend_circle = FriendCircle.find(params[:id])
  end

  def update
    @friend_circle = FriendCircle.find(params[:id])

    if @friend_circle.update_attributes(circle_params)
      redirect_to friend_circle_url(@friend_circle)
    else
      flash.now[:errors] = @friend_circle.errors.full_messages
      render :edit
    end
  end

  def destroy
    FriendCircle.find(params[:id]).destroy
    redirect_to friend_circles_url
  end

  private

  def circle_params
    params.require(:friend_circle).permit(:name, :member_ids => [])
  end
end
