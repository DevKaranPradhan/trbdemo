require 'rails_helper'

describe User::Operation::Welcome do
  before :each do
    @name = "testuser"
    @email = "test@test.com"
    @mobile_number = "9382943341"
    @password = "test123"
    @user = User.create(name: @name, email: @email, mobile_number: @mobile_number, password: @password)
    @token = JsonWebToken.encode(user_id: @user.id)
  end
  
  it 'return true on success' do
    result = described_class.call(token: @token)
    # byebug
    expect(result[:model]).to eq(@user)
  end
end