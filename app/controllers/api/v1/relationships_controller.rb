class Api::V1::RelationshipsController < Api::V1::ApplicationController
  # before_action :logged_in_user
  # skip_before_action :verify_authenticity_token
  before_action :doorkeeper_authorize!

  def index
    @following = current_user.following
    render json: @following
  end

  def follow
    user = User.find(params[:followed_id])
    current_user.follow(user)
    render json: user
  end

  def unfollow
    user = User.find(params[:followed_id])
    current_user.unfollow(user)
    render json: user
  end

end
