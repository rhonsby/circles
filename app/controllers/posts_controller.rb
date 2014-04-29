class PostsController < ApplicationController
  before_action :ensure_logged_in

  def new
    @post = Post.new
    5.times { @post.links.build }
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.links.build(link_params)

    if @post.save
      redirect_to post_url(@post)
    else
      (5 - @post.links.length).times { @post.links.build }
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def feed
    @posts = Post.shared_with_user(current_user).concat(current_user.posts)
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, friend_circle_ids: [])
  end

  def link_params
    params
    .permit(:link => [:name, :url])
    .require(:link)
    .values
    .reject { |link| link.values.all?(&:blank?) }
  end
end
