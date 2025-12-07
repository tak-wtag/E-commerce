class OrderPolicy < ApplicationPolicy
  def create?
    user.present? && user.buyer? && record.product.user_id != user.id
  end

  def show?
    user.present? && (record.user_id == user.id || record.product.user_id == user.id)
  end

  def destroy?
    user.present? && (record.user_id == user.id || record.product.user_id == user.id)
  end
  
  def mark_as_delivered?
    user.present? && user.seller? && record.product.user_id == user.id
  end

  class Scope < Scope
    def resolve
      return scope.none unless user
      if user.seller?
        scope.joins(:product).where(products: { user_id: user.id })
      elsif user.buyer?
        scope.where(user_id: user.id)
      else
        scope.none
      end
    end
  end
end
