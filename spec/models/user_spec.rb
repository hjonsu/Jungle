require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    it "should pass with all criteria" do
      @user = User.new
      @user.first_name = "Jono"
      @user.last_name = "Su"
      @user.email = "Jsu@jsu.com"
      @user.password = "12345"
      @user.password_confirmation = "12345"
      expect(@user.valid?).to be true
    end

    it "should not pass when password does not match" do
      @user = User.new
      @user.first_name = "Jono"
      @user.last_name = "Su"
      @user.email = "Jsu@jsu.com"
      @user.password = "123456"
      @user.password_confirmation = "12345"
      expect(@user.valid?).to be false
      expect(@user.errors.full_messages).to match(["Password confirmation doesn't match Password"])
    end

    it "should not pass when email already exists" do
      @user = User.new
      @user.first_name = "Jono"
      @user.last_name = "Su"
      @user.email = "Jsu@jsu.com"
      @user.password = "12345"
      @user.password_confirmation = "12345"
      @user.save

      @user2 = User.new
      @user2.first_name = "Jono"
      @user2.last_name = "Su"
      @user2.email = "jsu@JSU.com"
      @user2.password = "12345"
      @user2.password_confirmation = "12345"
      expect(@user2.valid?).to be false
      expect(@user2.errors.full_messages).to match(["Email has already been taken"])
    end

    it "should not pass when email does not exist" do
      @user = User.new
      @user.first_name = "Jono"
      @user.last_name = "Su"
      @user.email = nil
      @user.password = "12345"
      @user.password_confirmation = "12345"
      expect(@user.valid?).to be false
      expect(@user.errors.full_messages).to match(["Email can't be blank"])
    end

    it "should not pass when first_name does not exist" do
      @user = User.new
      @user.first_name = nil
      @user.last_name = "Su"
      @user.email = "Jsu@jsu.com"
      @user.password = "12345"
      @user.password_confirmation = "12345"
      expect(@user.valid?).to be false
      expect(@user.errors.full_messages).to match(["First name can't be blank", "First name is too short (minimum is 2 characters)"])
    end

    it "should not pass when last_name does not exist" do
      @user = User.new
      @user.first_name = "Jono"
      @user.last_name = nil
      @user.email = "Jsu@jsu.com"
      @user.password = "12345"
      @user.password_confirmation = "12345"
      expect(@user.valid?).to be false
      expect(@user.errors.full_messages).to match(["Last name can't be blank", "Last name is too short (minimum is 2 characters)"])
    end

    it "should not pass when password does not exist" do
      @user = User.new
      @user.first_name = "Jono"
      @user.last_name = "Su"
      @user.email = "Jsu@jsu.com"
      @user.password = nil
      @user.password_confirmation = nil
      expect(@user.valid?).to be false
      expect(@user.errors.full_messages).to match(["Password can't be blank", "Password can't be blank", "Password is too short (minimum is 5 characters)", "Password confirmation can't be blank"])
    end

    it "should not pass when password does not exist" do
      @user = User.new
      @user.first_name = "Jono"
      @user.last_name = "Su"
      @user.email = "Jsu@jsu.com"
      @user.password = "123"
      @user.password_confirmation = "123"
      expect(@user.valid?).to be false
      expect(@user.errors.full_messages).to match( ["Password is too short (minimum is 5 characters)"])
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should pass with valid credentials' do
      user = User.new(
        first_name: 'first_name',
        last_name: 'last_name',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )
      user.save

      user = User.authenticate_with_credentials('test@test.com', 'password')
      expect(user).not_to be(nil)
    end

    it 'should not pass with invalid email' do
      user = User.new(
        first_name: 'first_name',
        last_name: 'last_name',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )
      user.save

      user = User.authenticate_with_credentials('tes@test.com', 'password')
      expect(user).to be(nil)
    end

    it 'should not pass with invalid password' do
      user = User.new(
        first_name: 'first_name',
        last_name: 'last_name',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )
      user.save

      user = User.authenticate_with_credentials('test@test.com', '2password')
      expect(user).to be(nil)
    end

    it 'should pass with spaces before/after email' do
      user = User.new(
        first_name: 'first_name',
        last_name: 'last_name',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )
      user.save

      user = User.authenticate_with_credentials('  test@test.com  ', 'password')
      expect(user).not_to be(nil)
    end

    it 'should pass with different cased email' do
      user = User.new(
        first_name: 'first_name',
        last_name: 'last_name',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )
      user.save

      user = User.authenticate_with_credentials('  test@TEST.com  ', 'password')
      expect(user).not_to be(nil)
    end
  end
end
