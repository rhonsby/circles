class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    @post = @user.posts.new
    5.times { @post.links.new }
  end

  def create
    @user = User.new(user_params)
    @post = @user.posts.build(post_params)
    @post.links.build(link_params)

    if @user.save
      login!(@user)
      redirect_to root_url
    else
      (5 - @post.links.length).times { @post.links.build }
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def post_params
    params.require(:post).permit(:title)
  end

  def link_params
    params
    .permit(:link => [:name, :url])
    .require(:link)
    .values
    .reject { |link| link.values.all?(&:blank?) }
  end
end
