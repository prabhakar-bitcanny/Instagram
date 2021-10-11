class Api::V1::BlocksController < Api::V1::ApplicationController
  # before_action :logged_in_user
  before_action :doorkeeper_authorize!

  def index
    @blocking = current_user.blocking
    render json: @blocking
  end

  def block
    user = User.find(params[:blocked_id])
    current_user.block(user)
    render json: user
  end

  def unblock
    user = User.find(params[:blocked_id])
    current_user.unblock(user)
    render json: user
  end

end
