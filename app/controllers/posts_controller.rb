class PostsController < ApplicationController
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
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  private

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
