require 'rails_helper'

RSpec.describe Post, type: :model do

  context 'validation tests' do
    let(:u1) { User.create user_name: 'user1', name: 'user 1', email: 'u1@gmail.com', phone_no: 1112220000, password: "123456" }
    let(:post) { Post.create user_id: u1.id}
    it 'ensures caption presence' do
      # u1 = User.create(user_name: 'user1', name: 'user 1', email: 'u1@gmail.com', phone_no: 1112220000, password: "123456")
      # p u1.errors.full_messages
      # post = Post.create(user_id: u1.id)
      # p post.errors.full_messages
      # expect(post).to eq(true)
      expect(post.errors.full_messages).to eq(["Caption can't be blank"])
    end
  end
end
