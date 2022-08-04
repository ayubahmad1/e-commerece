# frozen_string_literal: true

class ProductPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def new?
    true
  end

  def create?
    true
  end

  def edit?
    true
  end

  def update?
    user == @record.user
  end

  def show?
    true
  end

  alias destroy? update?

  def comment?
    user != @record.user
  end
end
