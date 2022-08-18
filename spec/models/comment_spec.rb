require 'rails_helper'

RSpec.describe Comment, type: :model do
  # let(:comment1){build(:comment)}

  context 'Comments Specs' do

    describe 'Associations' do
      it { should belong_to(:user) }
      it { should belong_to(:product) }
    end

    describe 'Validations of fields' do
      it { is_expected.to validate_presence_of(:body)}
      it {is_expected.to validate_length_of(:body).is_at_most(20)}
    end
  end

end
