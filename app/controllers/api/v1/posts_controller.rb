class Api::V1::PostsController < Api::V1::ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  # skip_before_action :verify_authenticity_token
  before_action :doorkeeper_authorize!


  def index
    @posts = Post.all
    render json: @posts
  end

  def show
    render json: @post
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      render json: @post
    else
      render error: {error: "Unable to create post."}
    end
  end

  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors
    end
  end

  def destroy
    @post.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_post
    #   @post = Post.find(params[:id])
    # end
    def set_post
      @post = Post.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.to_s }, status: :not_found
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:caption, :user_id, images: [])
    end

end
