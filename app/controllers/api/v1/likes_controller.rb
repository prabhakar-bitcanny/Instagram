class Api::V1::LikesController < ApplicationController
  before_action :find_post
  before_action :find_like, only: [:destroy]
  # skip_before_action :verify_authenticity_token
  before_action :doorkeeper_authorize!

  def index
    @likes = @post.likes
    render json: @likes
  end

  def show
    render json: @post
  end


  def create
    if already_liked?
      flash[:notice] = "You can't like more than once"
    else
      @post.likes.create(user_id: current_user.id)
    end
    render json: @like
  end
  #
  # def create
  #   @post = Post.new(post_params)
  #   if @post.save
  #     render json: @post
  #   else
  #     render error: {error: "Unable to create post."}
  #   end
  # end

    # def destroy
    #   if !(already_liked?)
    #     flash[:notice] = "Cannot unlike"
    #   else
    #     @like.destroy
    #   end
    #   redirect_to posts_path
    # end

  private
    def find_post
      @post = Post.find(params[:post_id])
    end

    def already_liked?
      Like.where(user_id: current_user.id, post_id: params[:post_id]).exists?
    end

    def find_like
       @like = @post.likes.find(params[:id])
    end
end
