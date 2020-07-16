require 'rails_helper'

describe User::Operation::Show do
  before :each do
    @name = "testuser2"
    @email = "test2@test.com"
    @mobile_number = "9382943341"
    @password = "test123"
    @user = User.create(name: @name, email: @email, mobile_number: @mobile_number, password: @password)
  end

  it 'return true on success' do
    result = described_class.call(email: @email)
    # byebug
    expect(result[:user]).to eq(@user)
  end

  it 'failure to be true' do
    result = described_class.call(email: nil)

    expect(result.failure?).to be_truthy
  end
end