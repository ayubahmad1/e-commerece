require 'rails_helper'

RSpec.describe User, type: :model do

  context 'User Specs' do
    describe 'Callbacks' do
      it { should callback(:create_stripe_customer).after(:create) }
    end
  end
  # context 'Validation Test' do

  #   it 'must have an email' do
  #     user = User.new(name: 'Ayub', contact_number: '0000000000', address: 'Dummy adresss').save
  #     expect(user).to eq(false)
  #   end

  #   it 'must have unique email' do
  #     user1 = User.new(name: 'Ayub', contact_number: '0000000000', address: 'Dummy adresss 1', email: 'abc@example.com').save
  #     user2 = User.new(name: 'Ahmad', contact_number: '0000000000', address: 'Dummy adresss 2', email: 'abc@example.com').save
  #     expect(user2).to eq(false)
  #   end

  # end
end
