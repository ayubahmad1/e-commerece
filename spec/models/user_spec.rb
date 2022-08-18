require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build (:user) }

  context 'User Specs' do
    describe 'Associations' do
      it { is_expected.to have_one_attached(:image) }
      it { is_expected.to have_many(:products).dependent(:destroy) }
      it { is_expected.to have_many(:comments).dependent(:destroy) }
    end

    describe 'Callbacks' do
      it { should callback(:create_stripe_customer).after(:create) }
    end

    it 'valid image' do
      user.image = fixture_file_upload('/home/dev/e-commerece/app/assets/images/default1.jpeg', 'image/jpeg')
      expect(user).to be_valid
    end

    it 'invalid image' do
      user.image = fixture_file_upload('/home/dev/e-commerece/app/assets/stylesheets/errors.scss', 'text/scss')
      expect(user).not_to be_valid
    end
  end
end
