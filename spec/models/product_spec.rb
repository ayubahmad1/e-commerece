require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product1) { build(:product) }
  let(:product2) { build(:product) }
  # let(:user1) {build(:user1)}

  context 'Product Specs' do
    describe 'Validations of fields' do
      it { is_expected.to validate_presence_of(:name)}
      it {is_expected.to validate_length_of(:name).is_at_least(6)}
      # it {is_expected.to validate_length_of(:name).is_at_most(20)}

      it { is_expected.to validate_presence_of(:description)}
      it {is_expected.to validate_length_of(:description).is_at_least(20)}

      it { should validate_numericality_of(:quantity).only_integer }
      it { should validate_numericality_of(:quantity).is_greater_than(0) }
      it { should validate_numericality_of(:quantity).is_less_than(50000) }

      it { should validate_numericality_of(:price).only_integer }
      it { should validate_numericality_of(:price).is_greater_than(0) }
      it { should validate_numericality_of(:price).is_less_than(1000000) }
    end

    describe 'Associations' do
      it { should belong_to(:user) }
      it { is_expected.to have_many(:comments).dependent(:destroy) }
    end

    describe 'Callbacks' do
      it { should callback(:create_stripe_product).after(:create) }
    end

    # describe 'scopes' do
    #   it 'returns all products except mine' do
    #     expect(Product.all_products_except_mine(product1.user_id)).not_to include product1
    #     expect(Product.all_products_except_mine(product1.user_id)).to include product2
    #   end
    # end
  end


end
