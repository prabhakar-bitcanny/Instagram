class Api::V1::PostcommentsController < Api::V1::ApplicationController
  before_action :find_post
  before_action :set_article, only: [:show, :update, :destroy]
  # skip_before_action :verify_authenticity_token
  before_action :doorkeeper_authorize!

  def index
    @postcomments = @post.postcomments
    render json: @postcomments
  end

  def show
    render json: @postcomment
  end

  def create
    # p "------#{user_params}"
    @postcomment = Postcomment.new(postcomment_params)
    if @postcomment.save
      render json: @postcomment
    else
      render json: @postcomment.errors
    end
  end

  def update
    if @postcomment.update(postcomment_params)
      render json: @postcomment
    else
      render json: @postcomment.errors
    end
  end

  def destroy
    @postcomment.destroy
  end

private

  def postcomment_params
    params.require(:postcomment).permit(:content, :user_id, :post_id)
  end

  def set_article
   @postcomment = Postcomment.find(params[:id])
  end

  def find_post
    @post = Post.find(params[:post_id])
  end
end
