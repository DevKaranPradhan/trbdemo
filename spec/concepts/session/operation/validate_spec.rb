require 'rails_helper'

describe Session::Operation::Validate do
  before :each do
    @email = "test@test.com"
    @password = "test123"
  end

  it 'return true on success' do
    result = described_class.call(email: @email, password: @password)

    expect(result.success?).to be_truthy
  end

  it 'failure to be true' do
    result = described_class.call(email: nil, password: @password)

    expect(result.failure?).to be_truthy
  end

end