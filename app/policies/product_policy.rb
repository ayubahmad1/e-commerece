class ProductPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def update?
    user_is_owner_of_record?
  end

  def destroy?
    user_is_owner_of_record?
  end

  def comment?
    !user_is_owner_of_record?
  end

  private
  def user_is_owner_of_record?
    user == @record.user
  end
end
