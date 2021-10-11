class MsgsController < ApplicationController
  before_action do
    @chat = Chat.find(params[:chat_id])
  end

  def index
    @msgs = @chat.msgs
    @msg = @chat.msgs.new
  end

  def new
    @msg = @chat.msgs.new
  end

  def create
    @msg = @chat.msgs.new(msg_params)
    if @msg.save
      redirect_to chat_msgs_path(@chat)
    end
  end

  private

    def msg_params
      params.require(:msg).permit(:body, :user_id)
    end
end
