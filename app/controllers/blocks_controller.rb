class BlocksController < ApplicationController
  before_action :logged_in_user

  def create
    user = User.find(params[:blocked_id])
    current_user.block(user)
    redirect_to user
  end

  def destroy
    user = Block.find(params[:id]).blocked
    current_user.unblock(user)
    redirect_to user
  end

  private
    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def logged_in?
      !!current_user
    end

end
