require 'rails_helper'

describe User::Operation::Create do
  context 'when valid' do
    it do
      res = User::Operation::Create.(params: {
        name: "testuser3", 
        email: "test3@test.com", 
        mobile_number: "2304891231", 
        password: "test123"
      })

      byebug
      expect(res.success?).to eq(true)
      user = res["model"]
      expect(user.persisted?).to eq(true)
      expect(user.name).to eq("testuser3")
      expect(user.email).to eq("test3@test.com")
      expect(user.mobile_number).to eq("2304891231")
    end
  end

  context 'when email is blank' do
    it do
      res = User::Operation::Create.({
        email: ''
      })

      expect(res.failure?).to eq(true)
      expect(res["model"].persisted?).to eq(false)
      expect(res["contract.default"].errors.messages[:email]).to eq(["can't be blank"])
    end
  end
end