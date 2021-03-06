class Msg < ApplicationRecord
  belongs_to :chat
  belongs_to :user

  validates_presence_of :body, :chat_id, :user_id
end
