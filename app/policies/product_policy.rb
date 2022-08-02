# frozen_string_literal: true

class ProductPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def update?
    user == @record.user
  end

  alias destroy? update?

  def comment?
    user != @record.user
  end
end
