class Api::V1::UsersController < Api::V1::ApplicationController

  before_action :set_user, only: %i[ show edit update destroy ]
  # skip_before_action :verify_authenticity_token
  # before_action :find_user, only: :show

  def index
    @users = User.all
    render json: @users
  end

  def show
    render json: @user
  end

  def create
   p "------#{user_params}"
   @user = User.new(user_params)
   if @user.save
    render json: @user
   else
    render json: @user.errors
   end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors
    end
  end

  def destroy
    @user.destroy
  end

  private
    # def set_user
    #   @user = User.find(params[:id])
    # end
    def set_user
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.to_s }, status: :not_found
    end

    def user_params
      params.require(:user).permit(:name, :user_name, :email, :phone_no, :bio, :image, :password, :password_confirmation)
    end


end
