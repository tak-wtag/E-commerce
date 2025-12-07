class ReviewPolicy < ApplicationPolicy
  def create?
    user.present? && user.buyer? && record.product.user_id != user.id
  end

  def destroy?
    user.present? && record.user_id == user.id
  end

end
