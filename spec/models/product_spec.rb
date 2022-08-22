require 'rails_helper'

RSpec.describe Product, type: :model do

  describe 'Product Specs' do
    context 'Validations of fields' do
      it { is_expected.to validate_presence_of(:name)}
      it {is_expected.to validate_length_of(:name).is_at_least(6)}

      it { is_expected.to validate_presence_of(:description)}
      it {is_expected.to validate_length_of(:description).is_at_least(20)}

      it { should validate_numericality_of(:quantity).only_integer }
      it { should validate_numericality_of(:quantity).is_greater_than(0) }
      it { should validate_numericality_of(:quantity).is_less_than(50000) }

      it { should validate_numericality_of(:price).only_integer }
      it { should validate_numericality_of(:price).is_greater_than(0) }
      it { should validate_numericality_of(:price).is_less_than(1000000) }
    end

    context 'Associations' do
      it { should belong_to(:user) }
      it { is_expected.to have_many(:comments).dependent(:destroy) }
    end

    context 'Callbacks' do
      it { should callback(:create_stripe_product).after(:create) }
    end
  end


end
