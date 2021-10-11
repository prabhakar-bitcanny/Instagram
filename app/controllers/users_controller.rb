class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :following, :followers, :blocking, :blocked_by]

  def following
    title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    # render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    # render 'show_follow'
  end

  def blocking
    title = "Blocking"
    @user  = User.find(params[:id])
    @users = @user.blocking.paginate(page: params[:page])
    # render 'show_follow'
  end

  def blocked_by
    @title = "Blocked_by"
    @user  = User.find(params[:id])
    @users = @user.blocked_by.paginate(page: params[:page])
    # render 'show_follow'
  end

  def index
    if params[:search].present?
      @users = User.search(params[:search])
    else
      @users = User.where.not(id: current_user.id)
    end

    # for csv
    @datas = User.where(id: current_user.id)
    respond_to do |format|
      format.html
      format.csv { send_data @datas.to_csv }
    end
  end

  def edit
  end

  def show
    # @user = User.find_by_id(params[:id])
    # @user = User.friendly.find(params[:id])
    @user = User.find_by_user_name(params[:user_name])
    if @user.nil?
      @user = User.find_by_id(params[:user_name])
    end
    
  end

  def profile
    # @user = User.find_by_id(params[:current_user.id])
    # @user = User.find(current_user.id)
    # @user = User.friendly.find(current_user.id)
    redirect_to current_user
  end

  def search
    @users = User.search(params[:search])
  end

  private
    # Confirms a logged-in user.
    def logged_in_user
      # unless logged_in?
      #   store_location
      #   flash[:danger] = "Please log in."
      #   redirect_to login_url
      # end
    end

end
