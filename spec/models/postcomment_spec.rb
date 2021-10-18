require 'rails_helper'

RSpec.describe Postcomment, type: :model do
  context 'validation tests' do
    let(:u1) { User.create user_name: 'user1', name: 'user 1', email: 'u1@gmail.com', phone_no: 1112220000, password: "123456" }
    let(:post) { Post.create user_id: u1.id, caption: 'this post is testing validation postcomment'}
    let(:postcomment) { Postcomment.create post_id: post.id, user_id: u1.id, content: 'sfhgfgdfafgcmfhgsdafshfdxgjchfgsdafgsdhfxjgcjhfdsggshfdxjghfdsgszhfxjgfhghjhtrwtesdhetrwteyrhtrwteshgfgdzfgz' }
    it 'ensures comment length is in range of 100 characters' do
      # u1 = User.create(user_name: 'user1', name: 'user 1', email: 'u1@gmail.com', phone_no: 1112220000, password: "123456")
      # p u1.errors.full_messages
      # post = Post.create(caption: 'this post is testing validation postcomment', user_id: u1.id)
      # p post.errors.full_messages
      # postcomment = Postcomment.create(post_id: post.id, user_id: u1.id, content: 'sfhgfgdfafgcmfhgsdafshfdxgjchfgsdafgsdhfxjgcjhfdsggshfdxjghfdsgszhfxjgfhghjhtrwtesdhetrwteyrhtrwteshgfgdzfgz')
      # p postcomment.errors.full_messages
      expect(postcomment.errors.full_messages).to eq(["Content is too long (maximum is 100 characters)"])
    end
  end
end
