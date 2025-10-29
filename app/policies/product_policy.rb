class ProductPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.present? && user.seller?
  end

  def update?
    user.present? && user.seller? && record.user_id == user.id
  end

  def destroy?
    update?
  end
end
