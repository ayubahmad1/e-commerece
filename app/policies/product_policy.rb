class ProductPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  # def logged_in?
  #   user_logged_in?
  # end

  def update?
    user_is_owner_of_record?
  end

  def destroy?
    user_is_owner_of_record?
  end

  private
  def user_is_owner_of_record?
    user == @record.user
  end

  # def user_logged_in?
  #   @user?
  # end
end
