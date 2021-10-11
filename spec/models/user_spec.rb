require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation tests' do
    it 'ensures name presence' do
      user = User.create(user_name: 'prabhakar9', email: 'nayan@gmail.com', bio: 'First time I am doing web development', phone_no: 1112220000, password: "123456")
      # expect(user).to eq(false)
      # p user.errors.full_messages
      expect(user.errors.full_messages).to eq(["Name can't be blank"])
    end

    it 'ensures user_name presence' do
      user = User.create(name: 'Prabhakar Adak', email: 'nayan@gmail.com', bio: 'First time I am doing web development', phone_no: 1112220000, password: "123456")
      # expect(user).to eq(false)
      # p user.errors.full_messages
      expect(user.errors.full_messages).to eq(["User name can't be blank", "User name is too short (minimum is 5 characters)"])
    end

    it 'ensures email presence' do
      user = User.create(user_name: 'prabhakar9', name: 'Prabhakar Adak', bio: 'First time I am doing web development', phone_no: 1112220000, password: "123456")
      # expect(user).to eq(false)
      # p user.errors.full_messages
      expect(user.errors.full_messages).to eq(["Email can't be blank"])
    end

    it 'ensures phone number presence' do
      user = User.create(user_name: 'prabhakar9', name: 'Prabhakar Adak', email: 'nayan@gmail.com', bio: 'First time I am doing web development', password: "123456")
      # p user.errors.full_messages
      expect(user.errors.full_messages).to eq(["Phone no can't be blank"])
    end

    it 'successful signup' do
      # user1 = User.create(user_name: 'Kaif1', name: 'Md. Kaif', email: 'kaif@gmail.com', phone_no: 1112220000, password: "123456")
      # p user1.errors.messages
      # expect(user1).to eq(true)
      expect {
        User.create(user_name: 'Kaif1', name: 'Md. Kaif', email: 'kaif@gmail.com', phone_no: 1112220000, password: "123456")
      }.to change { User.count }
    end
  end

  context '#follow' do
    it "follows a user" do
      u1 = User.create(user_name: 'user1', name: 'user 1', email: 'u1@gmail.com', phone_no: 1112220000, password: "123456")
      # p u1.errors.full_messages
      u2 = User.create(user_name: 'user2', name: 'user 2', email: 'u2@gmail.com', phone_no: 1133220000, password: "123456")
      # p u2.errors.full_messages
      # u1.follow(u2)
      expect {
        u1.follow(u2)
      }.to change { Relationship.count }
      p u1.following
      expect(u1.following.first).to eq(u2)
    end
  end

  context '#block' do
    it "blocks a user" do
      u1 = User.create(user_name: 'user1', name: 'user 1', email: 'u1@gmail.com', phone_no: 1112220000, password: "123456")
      # p u1.errors.full_messages
      u2 = User.create(user_name: 'user2', name: 'user 2', email: 'u2@gmail.com', phone_no: 1133220000, password: "123456")
      # p u2.errors.full_messages
      # u1.follow(u2)
      expect {
        u1.block(u2)
      }.to change { Block.count }
      p u1.blocking
      expect(u1.blocking.first).to eq(u2)
    end
  end
end
