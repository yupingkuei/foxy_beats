class VinylPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def update?
    if record.user == user || user.admin
      return true
    end
  end

  def destroy?
    if record.user == user || user.admin
     return true
    end
 end
end
