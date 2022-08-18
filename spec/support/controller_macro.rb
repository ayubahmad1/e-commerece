# Taken from https://github.com/plataformatec/devise/wiki/How-To:-Test-controllers-with-Rails-3-and-4-(and-RSpec),
# with some minor changes

module ControllerMacros
  # def login_admin(&proc)
  #   before(:each) do
  #     @request.env["devise.mapping"] = Devise.mappings[:admin]
  #     admin_user = proc ? instance_eval(&proc): FactoryGirl.create(:admin_user)
  #     sign_in admin_user
  #   end
  # end

  def login_user(&proc)
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = proc ? instance_eval(&proc): FactoryBot.create(:user)
      # user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
      sign_in user
    end
  end
end
