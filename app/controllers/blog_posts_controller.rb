class BlogPostsController < ApplicationController
  before_action :set_blog_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @blog_posts = user_signed_in? ? BlogPost.all : BlogPost.published.sorted

    @pagy, @blog_posts = pagy(@blog_posts)
  rescue Pagy::OverflowError
    redirect_to root_path(page: 1)
    # params[:page] = 1
    # retry
  end

  def new
    @blog_post = BlogPost.new
  end

  def create
    @blog_post = BlogPost.new(blog_post_params)
    if @blog_post.save
      redirect_to @blog_post
    else
      render :new, status: :unprocessable_entity
    end
  end
  def show
  end

  def edit
  end

  def update
    if @blog_post.update(blog_post_params)
      redirect_to @blog_post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @blog_post.destroy
    redirect_to root_path
  end

  private

  def set_blog_post
    if user_signed_in?
      @blog_post = BlogPost.find(params[:id])
    else
      @blog_post = BlogPost.published.find(params[:id])
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  def blog_post_params
    params.require(:blog_post).permit(:title, :content, :published_at)
  end

  # this is the implementation
  # def authenticate_user!
  #   redirect_to new_user_session_path, alert: "You must sign in or sign up to cont" unless user_signed_in?
  # end
end
