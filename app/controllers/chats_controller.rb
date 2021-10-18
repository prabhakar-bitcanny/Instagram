class ChatsController < ApplicationController
  before_action :authenticate_user!

  def index
    following = current_user.following.pluck(:id)
    blocked_by = current_user.blocked_by.pluck(:id)
    unblocked_following = following - blocked_by
    @users = User.where(id: unblocked_following)

    @chats = Chat.all
  end



  def create
    if Chat.between(params[:sender_id], params[:recipient_id]).present?
       @chat = Chat.between(params[:sender_id], params[:recipient_id]).first
    else
       @chat = Chat.create!(chat_params)
    end
    redirect_to chat_msgs_path(@chat)
  end

  private

    def chat_params
      params.permit(:sender_id, :recipient_id)
    end
end
