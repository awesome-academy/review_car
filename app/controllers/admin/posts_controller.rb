class Admin::PostsController < ApplicationController
  before_action :require_admin, only: [:new,:destroy,:index]
  before_action :find_post, only: [:show,:edit,:update,:destroy] 


  def index
    if params[:post_type] == "init"
         @posts = Post.init.order_by_time
    elsif params[:post_type] == "rejected"
         @posts = Post.rejected.order_by_time
    elsif params[:post_type] == "accepted"
         @posts = Post.accepted.order_by_time
    end                 
  end  
  def new
    @post = Post.new
  end  
  def create
    @post = current_user.posts.build(post_params)
    @post.image.attach(params[:post][:image])

    if @post.save
      flash[:success] = "post created!"
      redirect_to admin_post_path(@post)
    else
      @posts = Post.all.paginate(page: params[:page])
      render 'new'
    end
  end
  def show
  end 
  def edit
  end  
  def update
    if @post.update(post_params)
      flash[:success] = "updated"
      redirect_to admin_posts_path(post_type: post_params[:status])
    else
      render 'edit'
    end
  end
  def destroy
      respond_to do |format|
        @post.destroy
        format.js
        format.html { redirect_to admin_posts_path }
      end
  end

  private
  def post_params
    params.require(:post).permit(:content, :image, :title, :status, :brand)
  end

  def find_post
      @post = Post.find_by id:params[:id] 
      if  @post.nil?
        redirect_to root_path
      end
   end 


  def require_admin
    unless current_user.admin?
      redirect_to root_path
    end
  end
end
